function [profiles] = Polygoner_ABQS_out(n, d, slend, fy, rcoef, nbend, lext, tg)
% Script that prints a .jnl ASCII file for Abaqus. The .jnl creates in
% Abaqus all the models from a given set of xy points.


% attempt to write to multiple lines to file (not finished yet, need to include variable in the text and combine all models) 
n = 9;
d = 300;
slend = 90;
fy = 355;
rcoef = 6;
nbend = 5;
lext = 30;
tg = 10;

% Initialise the cell array to host the profiles
profiles = cell(length(n), length(d), length(slend));

% Loop through the values 
for i = 1:length(n); 
    for j = 1:length(d);
        for k = 1:length(slend);
            [x, y] = pcoords(n(i), d(j), slend(k), fy, rcoef, nbend, lext, tg);
            profiles{i, j, k} = [x; y];
        end
    end
end

%aoutput for Abaqus

        
    
p = max(1:1:length(x))

    jnltext = ['from part import *' char(10) 'from material import *' char(10) 'from section import *' char(10) 'from assembly import *' char(10) 'from step import *' char(10) 'from interaction import *' char(10) 'from load import *' char(10) 'from mesh import *' char(10) 'from optimization import *' char(10) 'from job import *' char(10) 'from sketch import *' char(10) 'from visualization import *' char(10) 'from connectorBehavior import *' char(10) 'mdb.models.changeKey(fromName=''Model-1'',toName=''p111'')' char(10) 'mdb.models[''p111''].ConstrainedSketch(name=''__profile__'', sheetSize=1200.0)' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(1)) ', ' num2str(y(1)) '), point2=(' num2str(x(2)) ', ' num2str(y(2)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(2)) ', ' num2str(y(2)) '), point2=(' num2str(x(3)) ', ' num2str(y(3)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(3)) ', ' num2str(y(3)) '), point2=(' num2str(x(4)) ', ' num2str(y(4)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(4)) ', ' num2str(y(4)) '), point2=(' num2str(x(5)) ', ' num2str(y(5)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(5)) ', ' num2str(y(5)) '), point2=(' num2str(x(6)) ', ' num2str(y(6)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(6)) ', ' num2str(y(6)) '), point2=(' num2str(x(7)) ', ' num2str(y(7)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(7)) ', ' num2str(y(7)) '), point2=(' num2str(x(8)) ', ' num2str(y(8)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(8)) ', ' num2str(y(8)) '), point2=(' num2str(x(9)) ', ' num2str(y(9)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(9)) ', ' num2str(y(9)) '), point2=(' num2str(x(10)) ', ' num2str(y(10)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(10)) ', ' num2str(y(10)) '), point2=(' num2str(x(11)) ', ' num2str(y(11)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(11)) ', ' num2str(y(11)) '), point2=(' num2str(x(12)) ', ' num2str(y(12)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(12)) ', ' num2str(y(12)) '), point2=(' num2str(x(13)) ', ' num2str(y(13)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(13)) ', ' num2str(y(13)) '), point2=(' num2str(x(14)) ', ' num2str(y(14)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(14)) ', ' num2str(y(14)) '), point2=(' num2str(x(15)) ', ' num2str(y(15)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(15)) ', ' num2str(y(15)) '), point2=(' num2str(x(16)) ', ' num2str(y(16)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(16)) ', ' num2str(y(16)) '), point2=(' num2str(x(17)) ', ' num2str(y(17)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(17)) ', ' num2str(y(17)) '), point2=(' num2str(x(18)) ', ' num2str(y(18)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(18)) ', ' num2str(y(18)) '), point2=(' num2str(x(19)) ', ' num2str(y(19)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(19)) ', ' num2str(y(19)) '), point2=(' num2str(x(20)) ', ' num2str(y(20)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(20)) ', ' num2str(y(20)) '), point2=(' num2str(x(21)) ', ' num2str(y(21)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(21)) ', ' num2str(y(21)) '), point2=(' num2str(x(22)) ', ' num2str(y(22)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(22)) ', ' num2str(y(22)) '), point2=(' num2str(x(23)) ', ' num2str(y(23)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(23)) ', ' num2str(y(23)) '), point2=(' num2str(x(24)) ', ' num2str(y(24)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(24)) ', ' num2str(y(24)) '), point2=(' num2str(x(25)) ', ' num2str(y(25)) '))' char(10) 'mdb.models[''p111''].sketches[''__profile__''].Line(point1=(' num2str(x(25)) ', ' num2str(y(25)) '), point2=(' num2str(x(26)) ', ' num2str(y(26)) '))' char(10) 'mdb.models[''p111''].Part(dimensionality=THREE_D, name=''sector'', type=DEFORMABLE_BODY)' char(10) 'mdb.models[''p111''].parts[''sector''].BaseShellExtrude(depth=1200.0, sketch=mdb.models[''p111''].sketches[''__profile__''])' char(10) 'del mdb.models[''p111''].sketches[''__profile__'']' char(10) 'mdb.models[''p111''].Material(name=''pure-elastic'')' char(10) 'mdb.models[''p111''].materials[''pure-elastic''].Elastic(table=((210000.0, 0.3), ))'];

fid = fopen('polygons.jnl', 'w');

fwrite(fid, jnltext);

fclose(fid);



   




