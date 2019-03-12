%% usage: ssp = frjoin(ssp1,ssp2,k1,k2)
%%
%% Joins two magnitude frequency responses over the semispectrum,
%% mixing them over a given index interval.
%%
%% ssp  = Column vector with the resulting mix.
%% ssp1 = Column vector with the left side magnitudes.
%% ssp2 = Column vector with the right side magnitudes.
%% k1   = First interval index.
%% k2   = Second interval index.

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

function ssp = frjoin(ssp1,ssp2,k1,k2)

    if ! iscolumn(ssp1)
        error ("ssp1 must be a column vector")
    end

    if ! iscolumn(ssp2)
        error ("ssp2 must be a column vector")
    end

    if (length (ssp1) != length (ssp2))
        error ("frjoin: Spectrum lengths must be equal");
    end
    [trw1, trw2] = trwcos(k1,k2);
    m=length(ssp1);
    ssp1=[ssp1(1:k1-1);ssp1(k1:k2).*trw1;zeros(m-k2,1)];
    ssp2=[zeros(k1-1,1);ssp2(k1:k2).*trw2;ssp2(k2+1:m)];
    ssp=ssp1+ssp2;
    
endfunction
