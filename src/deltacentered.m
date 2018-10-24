%% This file is part of DSD
%%
%% DSD A GNU-Octave set of scripts for calculating
%% digital loudspeaker crossovers and room correction filters
%% Copyright (C) 2012-2018 Roberto Ripio
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

%% usage: imp = deltacentered(m)
%%
%% Obtiene un impulso de longitud m con valor uno en su muestra central.
%%
%% imp = Coeficientes del filtro FIR.
%% m = Número de muestras. Debe ser impar.

function imp=deltacentered(m);
	if (mod(m,2) == 0)
		error ("deltacentered: Impulse length must be odd");
	end
    imp=zeros(m,1);
    imp(ceil(m/2))=1;
end
