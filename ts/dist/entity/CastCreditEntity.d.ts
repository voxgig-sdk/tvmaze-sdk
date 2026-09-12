import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { CastCredit, CastCreditListMatch } from '../TvmazeTypes';
declare class CastCreditEntity extends TvmazeEntityBase<CastCredit> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: CastCreditEntity): CastCreditEntity;
    list(this: any, reqmatch?: CastCreditListMatch, ctrl?: Control): Promise<CastCreditEntity[]>;
}
export { CastCreditEntity };
