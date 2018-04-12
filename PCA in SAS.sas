/*Read in data*/
PROC IMPORT DATAFILE="/home/gihanid0/BA/job ratings.xlsx"
		    OUT=WORK.ratings
		    DBMS=XLSX
		    REPLACE;
RUN;

/* Extract principal components */
proc princomp data=WORK.ratings out=ratings_PC;
  var KNOWHOW PROBLEM_SOLVING ACCOUNTABILITY;
RUN;

/*correlations*/
PROC CORR DATA=ratings_PC;
 var KNOWHOW PROBLEM_SOLVING ACCOUNTABILITY;
WITH prin1 prin2 prin3;


/* Export the file with PCs to excel */
PROC EXPORT
	DATA=WORK.ratings_pc
	OUTFILE="/home/gihanid0/BA/ratings_pc.xlsx"
	DBMS=XLSX
	REPLACE;
RUN;


/* Q5 */
/* To standardize the variables into z1, z2, z3 */
PROC STDIZE
	DATA=ratings_PC
	OUT=ratings_pc_std;
 	var KNOWHOW PROBLEM_SOLVING ACCOUNTABILITY;
RUN;

PROC REG DATA=ratings_pc_std;
MODEL prin1 =  KNOWHOW PROBLEM_SOLVING ACCOUNTABILITY / NOINT;
RUN;
