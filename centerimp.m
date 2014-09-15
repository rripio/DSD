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

%% usage: imp = centerimp(imporig,m)
%%
%% Aumenta la longitud de un impulso centrándolo.
%% El impulso original debe tener longitud impar.
%%
%% imp = Coeficientes del filtro FIR.
%% imporig= Impulso a centrar. Debe ser de longitud impar.
%% m= Longitud final del impulso.

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