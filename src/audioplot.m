%% usage: audioplot(...
%%          F, dBmag, magtop, magrange, magstep, flow, fhigh, plotitle)
%%
%% Draws a frequency response graph with a conventional format.
%%
%% F        = Frequencies vector.
%% dBmag    = Magnitudes vector dB.
%% magtop   = Magnitude maximum (dB).
%% magrange = Visible range of magnitude (dB).
%% magstep  = dB steps for grid and labeling.
%% flow     = Frequency lower limit (Hz).
%% fhigh    = Frequency upper limit (Hz).
%% plotitle = Graph title.

%% This file is part of DSD
%%
%% DSD
%% GNU-Octave set of scripts for calculating
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
%%

function audioplot( F,
                    dBmag,
                    magtop=+6,
                    magrange=24,
                    magstep=3,
                    flow=10,
                    fhigh=30000,
                    plotitle="Frequency response" )

semilogx(F,dBmag);
audioaxe(magtop,magrange,magstep,flow,fhigh,plotitle);

endfunction
