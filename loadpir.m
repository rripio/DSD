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

%% usage pcm = loadpir(fname)
%%
%% load a pir file created by ARTA
%%
%% pcm	= Vector columna del impulso
%% fname = pir file name

function [pir, fs] = loadpir(fname)

	f = fopen(fname,"rb");
	[filesignature, filesignaturec] = fread(f, 4, "char");
	[version, versionc] = fread(f, 1, "unsigned int");
	[infosize, infosizec] = fread(f, 1, "int");
	[reserved, reservedc] = fread(f, 2, "int");
	[fskHz, fskHzc] = fread(f, 1, "float");
	[fs, fsc] = fread(f, 1, "int");
	[pirlength, pirlengthc] = fread(f, 1, "int");
	[inputdevice, inputdevicec] = fread(f, 1, "int");
	[devicesens, devicesensc] = fread(f, 1, "float");
	[various_int, various_intc] = fread(f, 5, "int");
	[various_float, various_floatc] = fread(f, 5, "float");
	[pir, pirc] = fread(f, pirlength, "float");
	% Don't read text
	fclose(f);
	
endfunction