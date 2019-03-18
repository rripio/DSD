%% usage: imp = centerimp(imporig,m)
%%
%% Centers an impulse in a given length.
%% Length of input impulse must be odd.
%%
%% imp     = FIR filter coefficients.
%% imporig = Impulse to center. Length must be odd.
%% m       = Final impulse length.

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

function imp=centerimp(imporig,m);
    l = length(imporig);
    if l > m
        error ("centerimp: impulse length must be equal or less than m");
    end
    if (mod(l,2) == 0)
        error ("centerimp: Impulse length must be odd");
    end
    imp=prepad(imporig, l+floor((m-l)/2));
    imp=postpad(imp,m);
end
