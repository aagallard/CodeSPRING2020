%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: C:\Users\aagal\Downloads\Fluids2020_Lab01Data.xlsx
%    Worksheet: Sheet1
%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 16);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "C3:R243";

% Specify column names and types
opts.VariableNames = ["Unimportant","x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15"];
opts.VariableTypes = ["categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "Unimportant", "EmptyFieldRule", "auto");

% Import the data
FData = readtable("C:\Users\aagal\Downloads\Fluids2020_Lab01Data.xlsx", opts, "UseExcel", false);


%% Clear temporary variables
clear opts

%% Actual Script

%STEPS
%create the different groupings of tables for each group
%convert to array with table2array
%get confidence interval for each on


% LOOP FOR FLOW 1 (5in)
for i = 6:22:226
    for j = 2:3:14
      matrix5{((i+16)/22), ((j+1)/3)} = table2array(FData(i:(i+6), j:(j+2)));
      %get rid of NaN columns
      matrix5{((i+16)/22), ((j+1)/3)} = matrix5{((i+16)/22), ((j+1)/3)}(:,all(~isnan(matrix5{((i+16)/22), ((j+1)/3)})));
    end
end

% LOOP FOR FLOW 1 (2.5in)
for i = 15:22:235
    for j = 2:3:14
      matrix2{((i+7)/22), ((j+1)/3)} = table2array(FData(i:(i+6), j:(j+2)));
      %get rid of NaN columns
      matrix2{((i+7)/22), ((j+1)/3)} = matrix2{((i+7)/22), ((j+1)/3)}(:,all(~isnan(matrix2{((i+7)/22), ((j+1)/3)})));
    end
end


%% PLOT 1 (5IN)
count = 0;
for i = 1:11
    for j = 1:5
            A = matrix5{i,j};
            N = numel(A);
            mean = sum(sum(A))/N;
            sd = sqrt(  (1/(N-1))  *  sum(sum(  ((A-mean).^2)  )));
        
            z = 1.960;
            count = count+1;
            
            if count < 54
            CIlower{count} = mean-z*sd/sqrt(N);
            CIupper{count} = mean+z*sd/sqrt(N);
            end
    end
end

figure(1);
hold;
for i = 1:53
    plot([CIlower{i} CIupper{i}], [ (-i) (-i)]);
end
xline(2.035);   
title("Flow Rate 1 (5 Inches)");
xlabel("In^3 / Sec");
ylabel("Groups");


%% PLOT 2 (2.5IN)

count = 0;
for i = 1:11
    for j = 1:5
            A = matrix2{i,j};
            N = numel(A);
            mean = sum(sum(A))/N;
            sd = sqrt(  (1/(N-1))  *  sum(sum(  ((A-mean).^2)  )));
        
            z = 1.960;
            count = count+1;
            
            if count < 54
            CIlower2{count} = mean-z*sd/sqrt(N);
            CIupper2{count} = mean+z*sd/sqrt(N);
            end
    end
end


figure(2);
hold;
for i = 1:53
    plot([CIlower2{i} CIupper2{i}], [ (-i) (-i)]);
end
xline(1.411);   
title("Flow Rate 2 (2.5 Inches)");
xlabel("In^3 / Sec");
ylabel("Groups");
 
     











