%% apply gain to leave the minimum of the passband at 0 dB.
%% band is determined by crossover points.
%% if no crossover at one end uses a given interval from crossover point.
%% if no crossover at all uses a given interval aranud full band center.

%% This file is part of DSD
%%
%% DSD
%% A GNU-Octave set of scripts for calculating
%% digital loudspeaker crossovers and room correction filters
%% Copyright (C) 2012-2019 Roberto Ripio
%%
%% DSD is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
%% DSD is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with DSD.  If not, see <https://www.gnu.org/licenses/>.



function leveldB = dsd_level_estimate (F,
                         dB,
                         LowF,
                         HighF,
                         LevelInterval)

    % calculates Band Limits
    % if no crossover band goes half LevelInterval
    % to each side of band center
    if LowF == 0 && HighF == 0
        bandcenter = sqrt(20*20000);
        LowF = bandcenter / 2^(LevelInterval/2);
        HighF = bandcenter * 2^(LevelInterval/2);
    elseif LowF == 0 && HighF != 0
        HighF = HighF;
        LowF = HighF / 2^(LevelInterval);
    elseif LowF != 0 && HighF == 0
        LowF = LowF;
        HighF = LowF * 2^(LevelInterval);
    endif
    LowK=ceil(LowF/F)+1;
    HighK=floor(HighF/F)+1;
    if HighK > length(dB); HighK = length(dB); end
    % level
    leveldB=min(dB(LowK:HighK));

endfunction

