import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { CrewCredit, CrewCreditListMatch } from '../TvmazeTypes';
declare class CrewCreditEntity extends TvmazeEntityBase<CrewCredit> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: CrewCreditEntity): CrewCreditEntity;
    list(this: any, reqmatch?: CrewCreditListMatch, ctrl?: Control): Promise<CrewCreditEntity[]>;
}
export { CrewCreditEntity };
