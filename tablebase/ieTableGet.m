function files = ieTableGet(T,varargin)
% Return the file names that match the conditions in varargin
%
% To do:  Maybe this should be ieTableFile because it returns the
%         data files.
%         We then write ieTableGet to return a subset of the table rows.
%
% Synopsis
%   files = ieTableGet(T,varargin)
%
% Brief
%   We manage data using tables with variables, in some cases.  The
%   tables include a slot for the data file.  We use this interface to
%   specify which rows of the table have the file of interest.
%
% Inputs
%   T - A table 
%
% Optional key/val pairs
%   operator - Either 'and' or 'or'.  Default: 'and'
%   fields - The table field names are permissible.  These strings should
%            be lower case in this ISETCam environment.
%
% Return
%   files - String array of file names matching the condition(s)
%
% See also
%   table

% Example:
%{
T = oeDatabaseCreate;
variableTypes = varfun(@class, T, 'OutputFormat', 'cell')

files = ieTableGet(T,'ewave',415)
variableTypes = varfun(@class, T, 'OutputFormat', 'cell')

files = ieTableGet(T,'subject','J')
variableTypes = varfun(@class, T, 'OutputFormat', 'cell')

files = ieTableGet(T,'ewave',415,'subject','J','substrate','tongue')
variableTypes = varfun(@class, T, 'OutputFormat', 'cell')

% Only subjects Z and J
files = ieTableGet(T,'operator','or','subject','Z','subject','J');
variableTypes = varfun(@class, T, 'OutputFormat', 'cell')

%}

%% Parse
% Force the fields to lower case
varargin = ieParamFormat(varargin);

assert(isa(T,'table'));
variableNames = T.Properties.VariableNames;
variableTypes = varfun(@class, T, 'OutputFormat', 'cell');

p = inputParser;
p.addRequired('T',@istable);
p.addParameter('operator','and',@(x)(ismember(x,{'and','or'})));

passedV = zeros(size(variableNames));
for vv=1:numel(variableNames)
    thisV = variableNames{vv};
    thisT = variableTypes{vv};
    
    % Doesn't deal with the case of two args for the same field, say
    % subject Z and subject D.  
    if any(strcmp(thisV, varargin))
        passedV(vv) = 1;
        % User passed in a condition for this variable
        if strcmp(thisT,'string')            
            p.addParameter(thisV,'',@ischar);
        elseif strcmp(thisT,'double')            
            p.addParameter(thisV,[],@isnumeric);
        else
            error('Variable types must be string or double. This is %s',thisT);
        end
    end
end

p.parse(T,varargin{:});
op = p.Results.operator;
idx = find(passedV);
files = '';
switch op
    case 'and'
        for ii=idx
            switch variableTypes{ii}
                case 'string'
                    val = p.Results.(variableNames{ii});
                    tmp = T(strcmp(T.(variableNames{ii}),val),:).file;                    
                case 'double'
                    val = p.Results.(variableNames{ii});
                    tmp = T(T.(variableNames{ii}) == val,:).file;
            end
            if isempty(files), files = tmp;
            else,              files = findCommonStrings(files,tmp);
            end
        end

    case 'or'
        for ii=idx
            switch variableTypes{ii}
                case 'string'
                    val = p.Results.(variableNames{ii});
                    tmp = T(strcmp(T.(variableNames{ii}),val),:).file;                    
                case 'double'
                    val = p.Results.(variableNames{ii});
                    tmp = T(T.(variableNames{ii}) == val,:).file;
            end
            if isempty(files), files = tmp;
            else,              files = cat(1,files,tmp);
            end
        end
        files = unique(files);

    otherwise
        error('Unknown operator %s\n',op);
end

if iscell(files), files = string(files)'; end

end

%% ----
function commonStrings = findCommonStrings(files, tmp)
    commonStrings = {};
    for ii = 1:length(files)
        if ismember(files{ii}, tmp)
            commonStrings{end+1} = files{ii}; %#ok<AGROW>
        end
    end
end
