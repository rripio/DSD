%% usage: xs = smoothlog (x,ppo,ppoSm)
%%
%% Suaviza un espectro logarítmico con un ancho dado en fracción de octava.
%%
%% xs    = Vector columna con el espectro logarítmico suavizado.
%% x     = Vector columna de valores reales con el espectro logarítmico.
%% ppo   = Fracción de octava del intervalo de frecuencias. 
%% ppoSm = Fracción de octava del suavizado.

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

function xs=smoothlog(x,ppo,ppoSm);

    if ! iscolumn(x)
        error ("x must be a column vector")
    end

    l = size(x,1);
    w = ppo/ppoSm;

    if w<3
        error("Smoothing step must at least tree times greater than frequency step.\n");
    elseif (ppoSm <= 0) || (ppo <= 0) 
        error("Steps must be positive");
    end
    
    if mod(w,2)==1
        wInt = w;
    else
        wInt = ceil(w)+!mod(ceil(w),2);
    end
    excess = floor(wInt/2);
    frac = (w-(wInt-2))/2;
    window = [frac;ones(wInt-2,1);frac];
    xs = conv(x,window);
    xs = xs(excess+1:excess+l)/sum(window);
        
end
