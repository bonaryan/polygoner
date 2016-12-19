function [curves, shapes] = Polygoner_CFSM(profiles, meta)
% Function that is called for a giver 3D cell array with profile coordinate
% data, executes CUFSM and returns the curves and shapes

% The 4d cell array 'meta' is converted to ta 3D (neglect different lambda)
% Select the highest slenderness. CUFSM analyzes for many sub-lentghs. No
% need to rerun the analysis for different physical  lengths. Selecting the
% longest (highest slenederness) will return the same signature curve.
meta = meta(:, :, :, end);

% Size of the output matrix
matrix_size = size(profiles);

% Initialise the curves and shapes cell arrays to host the results
curves = cell(matrix_size(1), matrix_size(2), matrix_size(3));
shapes = cell(matrix_size(1), matrix_size(2), matrix_size(3));

% Define constants
E = 210000; %[MPa]
v = 0.3;
G = E/(2*(1+v));
fy = 355;

% Define conditions
BC = 'S-S';

% Number of sub-lengths for which the eigenvalues are calculated
n = 100;

m_all = num2cell(ones(1, (n+1)));
neigs = 10;

% Loop executing CUFSM
for i = [1:matrix_size(1)];
    for j = [1:matrix_size(2)];
        for k = [1:matrix_size(3)];
            
            % Current profile xy
            c_prof1 = profiles{i, j, k}';
            
            % Current profile plate thickness
            t = meta{i, j, k}(2);
            
            % Current profile area and moment of inertia
            A = meta{i, j, k}(5);
            I = min([meta{i, j, k}(6), meta{i, j, k}(7)]);

            % Current profile lengths
            lengths = logspace(0, log10(meta{i, j, k}(8)), n);
            
            % Number of vertices on the current profile
            l_prof = length(c_prof1);
            
            % A column of ones
            col1 = ones(l_prof', 1);
            
%             % Construct the 2 extra parts by rotating the imported one
%             % Commented code: create rotation matrices for the case of 3
%             % sectors
%             R2 = [cos(-2*pi/3), -sin(-2*pi/3); sin(-2*pi/3), cos(-2*pi/3)];
%             R3 = [cos(2*pi/3), -sin(2*pi/3); sin(2*pi/3), cos(2*pi/3)];
%             for a = 1:l_prof;
%                 c_prof2(a, :) = (R2*c_prof1(a, :)')';
%                 c_prof3(a, :) = (R3*c_prof1(a, :)')';
%             end;
%             
            % Construct the 'node' array
            % Commented code: nodes for 3 sectors
%             node = [(1:l_prof)', c_prof1(:, 1), c_prof1(:, 2), col1, col1, col1, col1, 100*col1;
%                 (1*l_prof+1:2*l_prof)', c_prof2(:, 1), c_prof2(:, 2), col1, col1, col1, col1, 100*col1;
%                 (2*l_prof+1:3*l_prof)', c_prof3(:, 1), c_prof3(:, 2), col1, col1, col1, col1, 100*col1];
            
            node = [(1:l_prof)', c_prof1(:, 1), c_prof1(:, 2), col1, col1, col1, col1, 100*col1];
            
            % Construct the 'elem' array
%             % Commented code: elements for 3 sectors
%             elem = [(1:l_prof-1)', (1:l_prof-1)', (2:l_prof)', t*ones(l_prof-1', 1), 100*ones(l_prof-1', 1);
%                 (1*l_prof:2*l_prof-2)', l_prof+(1:l_prof-1)', l_prof+(2:l_prof)', t*ones(l_prof-1', 1), 100*ones(l_prof-1', 1);
%                 (2*l_prof-1:3*l_prof-3)', 2*l_prof+(1:l_prof-1)', 2*l_prof+(2:l_prof)', t*ones(l_prof-1', 1), 100*ones(l_prof-1', 1)];

            elem = [(1:l_prof-1)', (1:l_prof-1)', (2:l_prof)', t*ones(l_prof-1', 1), 100*ones(l_prof-1', 1)];
            
            % Construct the 'prop' array
            prop = [100, E, E, v, v, G ];
            
            % Define cFSM parameters (constrained FSM for separating the different
            % buckling modes)
            % Generate unit length base vectors and number of modes
            [~ ,~ ,~ ,~ ,~ ,~ ,~ , ndm, nlm, ~] = base_properties(node,elem);
            ngm = 4;
            nom = 2*(length(node(:,1))-1);
            GBTcon.glob = ones(1,ngm);
            GBTcon.dist = ones(1,ndm);
            GBTcon.local = ones(1,nlm);
            GBTcon.other = ones(1,nom);
            GBTcon.ospace = 1;
            GBTcon.orth = 2;
            GBTcon.couple = 1;
            GBTcon.norm = 1;
            
            set(ed_global,'String',sprintf('%i ',GBTcon.glob'));
            set(ed_dist,'String',sprintf('%i ',GBTcon.dist'));
            set(ed_local,'String',sprintf('%i ',GBTcon.local'));
            set(ed_other,'String',sprintf('%i ',GBTcon.other'));
            set(toggleglobal,'Value',1)
            set(toggledist,'Value',1)
            set(togglelocal,'Value',1)
            set(toggleother,'Value',1)
            modeflag=[1 1 1 1];
            
            

% for no cFSM, uncomment the following line
% GBTcon = struct('glob', 0, 'dist', 0, 'local', 0 , 'other', 0, 'ospace', [1], 'couple', [1], 'orth', [2]);
            
            % Constructing general constraints, springs
%             % Commented code: constraints between the DOFs of 3 sectors
%             constraints = [l_prof+2 1 1.000 l_prof-1 1 0.000 0 0
%                 l_prof+2 2 1.000 l_prof-1 2 0.000 0 0
%                 l_prof+2 3 1.000 l_prof-1 3 0.000 0 0
%                 2*l_prof+2 1 1.000 2*l_prof-1 1 0.000 0 0
%                 2*l_prof+2 2 1.000 2*l_prof-1 2 0.000 0 0
%                 2*l_prof+2 3 1.000 2*l_prof-1 3 0.000 0 0
%                 2 1 1.000 3*l_prof-1 1 0.000 0 0
%                 2 2 1.000 3*l_prof-1 2 0.000 0 0
%                 2 3 1.000 3*l_prof-1 3 0.000 0 0];
            constraints = 0;

            % Springs
            KK = 100e3;
            ku = cos(pi/6)*KK; % !!!Check which DOF is which!!!
            kw = sin(pi/6)*KK;
            springs = [2, 1,  ku, 0;
                2, 2, kw, 0;
                l_prof-1, 1, ku, 0;
                l_prof-1, 2, kw, 0];
            
            % Save the input variables from this run to a file. This file can be loaded
            % in CUFSM gui
            save('loadfile.mat', 'prop', 'node', 'elem', 'lengths', 'springs', 'constraints', 'GBTcon', 'BC', 'm_all', 'neigs');


            % Run the FSM strip analysis
%            [curves{i, j, k}, shapes{i, j, k}] =strip(prop, node, elem, lengths, springs, constraints, GBTcon, BC, m_all, neigs);
        end
    end
end