% Init.m: Load data from the hour and day file

% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

data_day = xlsread('C:\Users\Alessio\Google Drive\Bike Sharing Project\Egidi_Villardita - Bike Sharing [IS Project]\data\dayData.xlsx','','','basic');
data_hour = xlsread('C:\Users\Alessio\Google Drive\Bike Sharing Project\Egidi_Villardita - Bike Sharing [IS Project]\data\hourData.xlsx','','','basic');

data_day_labels = cellstr(['instant'; 'day    '; 'season '; 'yr     ';
    'mnth   '; 'holiday';	'weekday'; 'working'; 'weather'; 'temp   ';
    'atemp  '; 'hum    '; 'windspe'; 'casual '; 'registe'; 'cnt    ']);

data_hour_labels = cellstr(['instant'; 'day    '; 'season '; 'yr     ';
    'mnth   '; 'hour   '; 'holiday';	'weekday'; 'working'; 'weather';
    'temp   '; 'atemp  '; 'hum    '; 'windspe'; 'casual '; 'registe';
    'cnt    ']);

data_day_labels = upper(data_day_labels); %just output styling
data_hour_labels = upper(data_hour_labels);

%Initialize target vectors
cnt_day = zeros(731,1);
cnt_hour = zeros(17379,1);

%Fill target vectors
cnt_day = data_day(1:731,16);
cnt_hour = data_hour(1:17379,17);
