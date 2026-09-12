import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { Aka, AkaListMatch } from '../TvmazeTypes';
declare class AkaEntity extends TvmazeEntityBase<Aka> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: AkaEntity): AkaEntity;
    list(this: any, reqmatch?: AkaListMatch, ctrl?: Control): Promise<AkaEntity[]>;
}
export { AkaEntity };
