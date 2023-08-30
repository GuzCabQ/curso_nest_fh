import { FileTypeValidator, MaxFileSizeValidator } from "@nestjs/common";

export const fileValidators = [
    // new MaxFileSizeValidator({ maxSize: 1000 }),
    new FileTypeValidator({ fileType: 'image/pdf' }),
    new FileTypeValidator({ fileType: 'pdf' }),
  ];
  