const User = require('../models/user');
const jwt = require('jsonwebtoken');
const keys = require('../config/keys');

module.exports = {

    async getAll (req, res, next){
        try{
            //Para realizar una peticion asincrona (Tener todos los usarios en la constante data) 
            const data = await User.getAll();
            console.log(`Usuarios: ${data}`);
            return res.status(201).json(data);
        } catch (error) {
            console.log(`Error: ${error}`);
            return error.status(501).json({
                success: false,
                message: 'Error al obtener los usuarios'
            });
        }
    },

    async register(req, res, next){
        try {
            const user = req.body;
            const data = await User.create(user);

            return res.status(201).json({
                success: true,
                message:'El registro se realizo correctamente',
                data: data.id
            });

        } catch (error) {
            console.log(`Error: $(error)`);
            res.status(501).json({
                success: false,
                message:'Error en el registro de usuario',
                error: error
            });
        }
    },

    async login(req, res, next) {
        try {
                
            const email = req.body.email;
            const password = req.body.password;

            const myUser = await User.findByEmail(email);
            // Verifica que el correo ingresado se encuentre en la base de datos
            if(!myUser) {
                return res.status(401).json({
                    success: false,
                    message: 'El correo no fue encontrado'

                });
            }

            // Para que el token del usuario expire en una hora ademas de validar la contraseña en la base de datos
            if(User.isPasswordMatched(password, myUser.password)){
                const token = jwt.sign({id: myUser.id, email: myUser.email}, keys.secretOrKey, {
                    //expiresIn: (60*60*24) //1hora
                });
                const data = {
                    id: myUser.id,
                    name: myUser.name,
                    lastname: myUser.lastname,
                    email: myUser.email,
                    phone: myUser.phone,
                    image: myUser.image,
                    session_token: `JWT ${token}`
                    
                }

                return res.status(201).json({
                    success: true,
                    data: data,
                    message: 'El usuario ha sido autenticado'
                });
            }
            else {
                return res.status(401).json({
                    success: false,
                    message: 'La contraseña es incorrecta'
                });
            }

        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                success: false, 
                message: 'Error al momento de hacer login',
                error: error 
            });
        }
    }

    

};

// 201 Ha tenido exito y se ha creado un resultado

// 501 el metodo no esta soportado por el servidor y no puede ser manejado

//401 No existe el recurso solicitado