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

%% usage: [minph, excph] = minexcphsp (sp)
%%
%% Obtiene el espectro de fase mínima y el pasa-todo con el exceso de fase a partir de un espectro completo.
%%
%% minph 	= Espectro completo de fase mínima con la misma magnitud de espectro que imp.
%% excph 	= Espectro pasatodo de exceso de fase.
%% sp 		= Espectro completo. Longitud par.

function [minph, excph] = minexcphsp (sp)

	if ! iscolumn(sp)
		error ("sp must be a column vector")
	end

	minph = minphsp (sp);
	excph = sp ./ minph;

endfunction
