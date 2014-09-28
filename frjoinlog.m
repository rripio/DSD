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

%% usage: ssp = frjoinlog(ssp1,ssp2,k1,k2)
%%
%% Une dos respuestas en magnitud sobre el semiespectro, mezclándolas en un intervalo de
%% índices dado. Asume que las respuestas a unir están en magnitud logarítmica sobre una 
%% escala de frecuencias logarítmica.
%%
%% ssp	= Vector columna con la magnitud de la mezcla.
%% ssp1	= Vector columna con la respuesta a mezclar por la izquierda.
%% ssp2	= Vector columna con la respuesta a mezclar por la derecha.
%% k1	= Primer índice del intervalo.
%% k2	= Segundo índice del intervalo.

function ssp = frjoinlog(ssp1,ssp2,k1,k2)

	if ! iscolumn(ssp1)
		error ("ssp1 must be a column vector")
	end

	if ! iscolumn(ssp2)
		error ("ssp2 must be a column vector")
	end

	if (length (ssp1) != length (ssp2))
		error ("frjoin: Spectrum lengths must be equal");
	end
    [trw1, trw2] = trwcoslog(k1,k2);
    m=length(ssp1);
    ssp1=[ssp1(1:k1-1);ssp1(k1:k2).*trw1;zeros(m-k2,1)];
    ssp2=[zeros(k1-1,1);ssp2(k1:k2).*trw2;ssp2(k2+1:m)];
    ssp=ssp1+ssp2;
    
endfunction