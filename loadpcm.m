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

%% usage pcm = loadpcm(fname)
%%
%% load a pcm raw file created by DRC
%%
%% fname = pcm file name
%% the file must be in 32 bit floating point format

function pcm = loadpcm(fname)

	f = fopen(fname,"rb");
	[pcm, pcmc] = fread(f,inf,"float32");
	fclose(f);
	
endfunction