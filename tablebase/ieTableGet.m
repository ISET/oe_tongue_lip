function tableReturn = ieTableGet(T,varargin)
% Return the rows that match the conditions in varargin
%
% Synopsis
%   tableReturn = ieTableGet(T,varargin)
%
% Brief
%   We sometimes manage data using tables with variables.  We use this
%   function to retrieve rows of the table whose fields match the specified
%   variables.
%
% Inputs
%   T - A table 
%
% Optional key/val pairs
%   operator - Either 'and' or 'or'.  Default: 'and'
%
%   fields - The table field names with a specified condition are all
%            permissible for the field. The field strings should be lower
%            case in this ISETCam environment.
%
%   return - Type of data to be returned.  By defult, it is the rows of the
%            table ('table rows').  It can be the data files (T.file)
%            assocated with the rows. 
%
% Return
%   tableReturn - String array of file names matching the condition(s)
%
% Description:
%
%   The data table, T, has metadata fields and usually a slot for the data
%   file. We use this function, ieTableGet, to retrieve the subset of table
%   rows whose fields match the values specified in the input arguments. We
%   can also ask ieTableGet to return an array of strings with the file
%   names that match.
%
%   The varargin fields beyond 'operator' and 'return' must be a table
%   field name and value.  The same field name can be used multiple times
%   when the operation is an 'or'.  For an 'and' operation, multiple field
%   names is likely to lead to an empty return.
%
% See also
%   table

% Example:
%{
% 'and' case
T = oeDatabaseCreate;
tRows = ieTableGet(T,'ewave',415); size(tRows,1)
tRows = ieTableGet(T,'subject','J'); size(tRows,1)
tRows = ieTableGet(T,'ewave',415,'subject','J','substrate','tongue'); size(tRows,1)
files = ieTableGet(T,'ewave',415,'subject','J','substrate','tongue','return','file')
%}
%{
% 'or' case
T = oeDatabaseCreate;
tRows = ieTableGet(T,'subject','Z');size(tRows,1)
tRows = ieTableGet(T,'subject','J');size(tRows,1)
tRows = ieTableGet(T,'operator','or','subject','Z','subject','J');size(tRows,1)
files = ieTableGet(T,'operator','or','subject','Z','subject','J','return','files');size(files,1)
%}

%% Parse
% Force the fields to lower case
varargin = ieParamFormat(varargin);

assert(isa(T,'table'));
variableNames = T.Properties.VariableNames;
variableTypes = varfun(@class, T, 'OutputFormat', 'cell');

p = inputParser;
p.KeepUnmatched = true;

p.addRequired('T',@istable);
p.addParameter('operator','and',@(x)(ismember(x,{'and','or'})));
p.addParameter('return','rows',@ischar);

p.parse(T,varargin{:});
op = p.Results.operator;
tReturn = p.Results.return;

%% Walk through conditions in varargin

% If the varargin entry is a variable name, then process it.

rows = [];
for ii=1:2:numel(varargin)
    if ismember(varargin{ii},{'operator','return'})
        % do nothing
    else
        % Find the argument and its type.
        [~,idx] = ismember(varargin{ii},variableNames);
        if isempty(idx), error('%d: %s is not a variable name.',ii,varargin{ii});
        else, thisV = variableNames{idx}; thisT = variableTypes{idx}; val = varargin{ii+1}; end

        switch thisT
            case 'string'
                tmp = find(T.(thisV) == val);
            case 'double'
                tmp = find(T.(thisV) == val);
        end

        switch op
            case 'and'
                if isempty(rows), rows = tmp;
                else,             rows = intersect(rows,tmp);
                end

            case 'or'
                if isempty(rows), rows = tmp;
                else,             rows = unique(cat(1,rows,tmp));
                end

            otherwise
                error('Unknown operator %s\n',op);
        end
    end
end

switch tReturn
    case 'rows'
        tableReturn = T(rows,:);
    case {'files','file'}
        tableReturn = T(rows,:).file;
    otherwise
        error('Unknown return type %s\n',tReturn);
end

end
