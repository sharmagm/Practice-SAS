DATA OBSERVATIONS;                                                                                                                               
DO J = 1 TO 200; /*SIMULATING 200 OBSERVATIONS*/                                                                                                                        
X1 = 1 + SQRT(4) * RANNOR(12);                                                                                                                   
X2 = 3 + SQRT(1) * RANNOR(12);                                                                                                                   
CALCULATEDNOISE = RANNOR(12);                                                                                                                     
Y = 1 + (2*X1) - (1.5*X2) + CALCULATEDNOISE; /* Y = ALPHA + BETA1 * X1 + BETA2 * X2 + NOISE */ 
 
/*STEP 2*/                                                                                                            
IF Y > 0 THEN
	Y_BIN=1;                                                                                                                    
ELSE 
	Y_BIN=0;                                                                                                                           
OUTPUT;                                                                                                                                 
END;

/*STEP 3*/
DATA NEW_OBS;
SET OBSERVATIONS;
KEEP X1 X2 Y Y_BIN;
RUN;
PROC PRINT DATA=NEW_OBS; 

/*STEP 4*/
PROC MEANS DATA=NEW_OBS RANGE; /*CALCULATING RANGE OF X1 AND X2*/                                                                                                              
VAR X1 X2;                                                                                                                              
RUN;

/*STEP 5*/
PROC UNIVARIATE DATA=NEW_OBS;
VAR Y;
HISTOGRAM Y/NORMAL;	
PROBPLOT Y/NORMAL;
RUN;

/*STEP 6*/
PROC FREQ DATA=NEW_OBS; /* COUNTING NUMBER OF Y_BIN HAVING VALUE AS 1 */
WHERE Y_BIN = 1;
TABLE Y_BIN;
RUN;

/*STEP 7*/
DATA NEW_OBS_2;
SET NEW_OBS;
IF Y_BIN= 1 THEN SIGN = "POSITIVE"; /* ADDED ANOTHER VARIABLE SIGN TO TABLE */
ELSE SIGN = "NEGATIVE";
RUN;
PROC PRINT DATA=NEW_OBS_2;

/*STEP 8*/
DATA NEW_OBS_3;
SET NEW_OBS_2;
RUN;
PROC SORT DATA=NEW_OBS_3;
BY SIGN;  
PROC MEANS DATA=NEW_OBS_3; /* COMPARING THE DISTRIBUTION OF X1 IN THE POSITIVE AND NEGATIVE GROUP */
BY SIGN;
VAR X1;
RUN;
/* END OF ASSIGNMENT 2 */
