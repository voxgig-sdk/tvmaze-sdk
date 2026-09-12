import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { Update, UpdateLoadMatch } from '../TvmazeTypes';
declare class UpdateEntity extends TvmazeEntityBase<Update> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: UpdateEntity): UpdateEntity;
    load(this: any, reqmatch?: UpdateLoadMatch, ctrl?: Control): Promise<UpdateEntity>;
}
export { UpdateEntity };
