%% Copyright (C) 2012 Roberto Ripio
%%
%% This program is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, write to the Free Software
%% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%%
%% This function is part of DSD

%% usage: imp = deltacentered(m)
%%
%% Obtiene un impulso de longitud m con valor uno en su muestra central.
%%
%% imp = Coeficientes del filtro FIR.
%% m = número de muestras. Debe ser impar.

function imp=deltacentered(m);
	if (mod(m,2) == 0)
		error ("deltacentered: Impulse length must be odd");
	end
    imp=zeros(m,1);
    imp(ceil(m/2))=1;
end