import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { Cast, CastListMatch } from '../TvmazeTypes';
declare class CastEntity extends TvmazeEntityBase<Cast> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: CastEntity): CastEntity;
    list(this: any, reqmatch?: CastListMatch, ctrl?: Control): Promise<CastEntity[]>;
}
export { CastEntity };
