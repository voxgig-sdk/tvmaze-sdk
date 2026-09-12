import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { Image, ImageListMatch } from '../TvmazeTypes';
declare class ImageEntity extends TvmazeEntityBase<Image> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: ImageEntity): ImageEntity;
    list(this: any, reqmatch?: ImageListMatch, ctrl?: Control): Promise<ImageEntity[]>;
}
export { ImageEntity };
