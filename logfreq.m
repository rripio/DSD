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

function logf=logfreq(m,fs,ppo);

	f2 = fs/2;
	f1 = fs/m;
	jump = 2^(1/ppo);
	steps = log(f2/f1)/log(jump);
	top = ceil(steps);
	logf = ((1:top)')+(top-steps-1/2); % vector columna
	logf = f1*(jump.^logf);

end
