function text = data2latex(data_table,decimal)

data_rounded = round(data_table,decimal);

x = size(data_rounded,1);
y = size(data_rounded,2);

text = [''];

%data_char = num2str(data_rounded);
a = ' \';
b = '\';

for i = 1:x
    for j = 1:y
        if j == y
            text = [text num2str(data_rounded(i,j)) a b newline];
        else
            text = [text num2str(data_rounded(i,j)) ' & '];
        end
    end
end
