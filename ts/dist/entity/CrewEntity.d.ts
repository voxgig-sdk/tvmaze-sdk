import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { Crew, CrewListMatch } from '../TvmazeTypes';
declare class CrewEntity extends TvmazeEntityBase<Crew> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: CrewEntity): CrewEntity;
    list(this: any, reqmatch?: CrewListMatch, ctrl?: Control): Promise<CrewEntity[]>;
}
export { CrewEntity };
