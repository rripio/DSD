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

%% usage: imps = loadpcms (filemask, kinit, kend)
%%
%% Carga archivos impulso que verifican una máscara en una matriz de vectores columna.
%%
%% imps	= matriz de vectores columna con los impulsos.
%% n		= número de impulsos.
%% filemask	= máscara de nombres de archivo (string).
%% kinit	= índice para el comienzo del recorte.
%% kend		= índice para el comienzo del recorte.

function [imps, n] = loadpcms (filemask, kinit, kend)

	impnames = glob (filemask);
	n = size (impnames, 1);
	l = kend-kinit+1;
	imps = zeros(l, n);
	for i = 1:n;
		temp = loadpcm(impnames(i));
		temp = temp(kinit:kend);
		imps(:,i) = temp;
	end;

endfunction