%% usage: xs = smoothpw (xws,ppo)
%%
%% Suaviza en potencia un semiespectro real con un ancho dado en
%% fracción de octava.
%%
%% xsss = Vector columna con el semiespectro suavizado.
%% xws  = Vector columna de valores reales (magnitud o fase)
%%        del semiespectro.
%% ppo  = Fracción de octava del suavizado.

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

function xwss=smoothpw(xws,ppo);

    if ! iscolumn(xws)
        error ("xws must be a column vector")
    end

    xws = xws.^2;
    xwss = smooth(xws,ppo);
    xwss = xwss.^0.5;

end
