export const fileFilter = ( req: Express.Request, file: Express.Multer.File, callback: Function ) => {

    // console.log({ file })
    if ( !file ) return callback( new Error('File is empty'), false );


    const fileExtension = file.mimetype;
    console.log(file.mimetype);
    const validExtensions = ['image/jpg','image/jpeg','image/png','image/gif','application/pdf'];

    if (  validExtensions.includes( fileExtension ) ) {
        return callback( null, true )
    }

    callback(null, false );

}