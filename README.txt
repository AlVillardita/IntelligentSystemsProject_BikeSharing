===================================================================================================
+                          Bike Sharing - Project in Intelligent Systems                          +
+                                 @ University of Pisa (unipi.it)                                 +
+                                          Developed by                                           +
+                        Alessio Villardita [villardita.alessio@gmail.com]                        +
+                                Sara Egidi [egidi.sara@gmail.com]                                +
===================================================================================================
Here is listed the required software for successfully running the trainings. The listing order is meaningful, so the correct results
can be obtained by executing these commands in this specific order. 

REQUIRED SCRIPTS:
1) init.m 	 					Script: the source must be modified by changing the path to the two data sets
2) fitFeatureSize.m  	 		Function: called by other functions/scripts
3) mlpNFeatures.m    			Function: call example "mlpNFeatures(data_day, cnt_day, [10 12], [3 11 13], 10, 10, data_day_labels)"
								Output example: Training with 2 features FIXED:TEMP	HUM	
									33.33% Feature: SEASON with error = 1.358e+06
									66.67% Feature: ATEMP with error = 1.605e+06
									100.00% Feature: WINDSPE with error = 1.465e+06

									Best feature: SEASON with error = 1.358e+06
									
4) mlp2Features.m  				Function: call example "mlp2Features(data_day, cnt_day, [10 12 3], 10, 10, data_day_labels)"
								Output example: Training with all the possible couples of features
									33.33% Features: (TEMP,HUM)
									66.67% Features: (TEMP,SEASON)
									100.00% Features: (HUM,SEASON)

									Best couple of features: (TEMP,HUM) with error = 1.606e+06
									
5) dataSetMonthIntervals.m 		Function: call example "dataSetMonthIntervals(data_day)"
								Output: 24x2 matrix 

6) rbfFitting.m 	  	 		Function: call example "rbfFitting(data_hour, [10 12], hour_months_intervals, cnt_hour, 1.0e+06, 0.1:0.1:1)"
								Output: newrb's outputs + progress status outputs + final spreads vs MSEs plot
					
7) rbfFittingIter.m 	 		Function: call example "rbfFittingIter(data_day, [10 12], day_months_intervals, cnt_day, 1.5e+06, 0.1:0.1:0.2, 2, data_day_labels)"
								Output: newrb's outputs + progress status outputs + final spreads vs MSEs plot

8) evalMyFIS.m 		 			Function: call example "evalMyFIS(FIS_Day, data_day(:,[12 10 3 13]), cnt_day)"
								Output: ans = 2.4372e+06
					
9) datasetPartitioning.m  		Function: call example "[ tr, tst, chk ] = datasetPartitioning(data_day, 0.7, 0, 0.3, [10, 12, 13])"
								Output: 3 matrices with the training, testing and checking data subsets in order.
					
10) NTSDay.m  					Function
11) DayForecastFeature.m 		Function: call example "DayForecastFeatures (data_day, cnt_day,[7 9 10 11 12 13],15,10,data_day_labels)"
								Output: mse, plot
12) DayForecast2Features.m 		Function: call example "DayForecast2Features(data_day, cnt_day,[7 9 10 11 12 13],5,10,data_day_labels)"
								Output: mse, plot
13) DayForecastNFeatures.m 		Function: call example "DayForecastNFeatures(data_day, cnt_day,[7 13 11],5,10,data_day_labels)"
								Output: mse, plot
14) DayForecastHiddenLayer.m 	Function: call example "DayForecastHiddenLayer(data_day, cnt_day, 2,15)"
								Output: mse, plot
15) ntsDayClosed.m 				Function
16) dayForecastingClosed.m 		Function: call example "[net, mse] = dayForecastingClosed(data_day, cnt_day, [12 10 9 7], 2, 14, 1, [1 2 7 10 15])"
								Output: plots, network and MSEs.
					
					


