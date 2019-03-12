%% usage: wsp = wholespmp (ssp)
%%
%% Gets the causal full spectrum from positive frequencies spectrum.
%%
%% wsp = Full spectrum from 0 to m-1 (m even).
%% ssp = Positive frequencies spectrum from 0 to m/2.

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

function wsp = wholespmp (ssp)

    if ! iscolumn(ssp)
        error ("ssp must be a column vector")
    end

    m = length (ssp); 
    if (mod(m,2) == 0)
        error ("wholespmp: Spectrum length must be odd");
    end
    nsp = flipud(conj(ssp(2:m-1)));
    wsp = [ssp;nsp];
    
endfunction
