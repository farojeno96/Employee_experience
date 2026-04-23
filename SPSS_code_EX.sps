* Encoding: UTF-8.

/* getting the data.
GET DATA
  /TYPE=XLSX
  /FILE='C:\Users\Jenő\Desktop\ELTE\2024 ősz - GTK\Egyebek\Laurának segítség\SPSS_1.xlsx'
  /SHEET=name 'adattábla_2024.09.26._kérdések '
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0
  /HIDDEN IGNORE=YES.
EXECUTE.
DATASET NAME $DataSet WINDOW=FRONT.

/* We exclude the cases where we received no valid response for the question: In which sector do you work?.

DATASET ACTIVATE $DataSet.
USE ALL.
COMPUTE filter_$=(Kéremjelöljemeghogyholdolgozik  >= 1  | Kéremjelöljemeghogyholdolgozik <= 3).
VARIABLE LABELS filter_$ 'Kéremjelöljemeghogyholdolgozik  >= 1  | Kéremjelöljemeghogyholdolgozik '+
    '<= 3 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


/* Checking reliability for all dimensions.
/*Klán = Clan.
DATASET ACTIVATE $DataSet.
RELIABILITY
  /VARIABLES=Klán1 Klán2 Klán3 Klán4 Klán5 Klán6 Klán7
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE CORR
  /SUMMARY=TOTAL.

/*Adhokrácia = Adhocracy.
DATASET ACTIVATE $DataSet.
RELIABILITY
  /VARIABLES=Adhok1 Adhok2 Adhok3 Adhok4 Adhok5 Adhok6 Adhok7 
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE CORR
  /SUMMARY=TOTAL.

/* Hierarchia = Hierarchy.
DATASET ACTIVATE $DataSet.
RELIABILITY
  /VARIABLES=Hierar1 Hierar2 Hierar3 Hierar4 Hierar5 Hierar6 Hierar7  
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE CORR
  /SUMMARY=TOTAL.


/* Piac = Market.
DATASET ACTIVATE $DataSet.
RELIABILITY
  /VARIABLES=Piac1 Piac2 Piac3 Piac4 Piac5 Piac6 Piac7 
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE CORR
  /SUMMARY=TOTAL.


/* Fizikai = Physical.
DATASET ACTIVATE $DataSet.
RELIABILITY
  /VARIABLES= Fizika1 Fizikai2 Fizikai3 Fizikai4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE CORR
  /SUMMARY=TOTAL.

/* Kultúra = Cultural.
DATASET ACTIVATE $DataSet.
RELIABILITY
  /VARIABLES= Kultúra1 Kultúra2 Kultúra3 Kultúra4 Kultúra5 Kultúra6 Kultúra7 Kultúra8 Kultúra9 Kultúra10
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE CORR
  /SUMMARY=TOTAL.

/* Technológia = Technological.
DATASET ACTIVATE $DataSet.
RELIABILITY
  /VARIABLES= Technológia1 Technológia2 Technológia3
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE CORR
  /SUMMARY=TOTAL.


/* Forming principal components - Clan.
DATASET ACTIVATE $DataSet.
FACTOR
  /VARIABLES Klán1 Klán2 Klán3 Klán4 Klán5 Klán6 Klán7
  /MISSING LISTWISE 
  /ANALYSIS Klán1 Klán2 Klán3 Klán4 Klán5 Klán6 Klán7
  /PRINT INITIAL CORRELATION KMO EXTRACTION FSCORE
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

RENAME VARIABLES (FAC1_1 = FAC_klan_1).
VARIABLE LABELS FAC_klan_1 'Klán kultúra aggregált értéke'.

/* 1 PC was retained.

/* Forming principal components - Adhocracy.
DATASET ACTIVATE $DataSet.
FACTOR
  /VARIABLES Adhok1 Adhok2 Adhok3 Adhok4 Adhok5 Adhok6 Adhok7
  /MISSING LISTWISE 
  /ANALYSIS Adhok1 Adhok2 Adhok3 Adhok4 Adhok5 Adhok6 Adhok7
  /PRINT INITIAL CORRELATION KMO EXTRACTION FSCORE
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

/* 1 PC was retained.
RENAME VARIABLES (FAC1_1 = FAC_adhok_1).
VARIABLE LABELS FAC_adhok_1 'Adhokrácia kultúra aggregált értéke'.


/* Forming principal components - Hierarchy.
DATASET ACTIVATE $DataSet.
FACTOR
  /VARIABLES Hierar1 Hierar2 Hierar3 Hierar4 Hierar5 Hierar6 Hierar7
  /MISSING LISTWISE 
  /ANALYSIS Hierar1 Hierar2 Hierar3 Hierar4 Hierar5 Hierar6 Hierar7
  /PRINT INITIAL CORRELATION KMO EXTRACTION FSCORE
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

/*1 PC was retained.
RENAME VARIABLES (FAC1_1 = FAC_hierar_1).
VARIABLE LABELS FAC_hierar_1 'Hierarchia kultúra aggregált értéke'.

/* Forming principal components - Market.
DATASET ACTIVATE $DataSet.
FACTOR
  /VARIABLES Piac1 Piac2 Piac3 Piac4 Piac5 Piac6 Piac7
  /MISSING LISTWISE 
  /ANALYSIS Piac1 Piac2 Piac3 Piac4 Piac5 Piac6 Piac7
  /PRINT INITIAL CORRELATION KMO EXTRACTION FSCORE
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

/* 1 PC was retained.
RENAME VARIABLES (FAC1_1 = FAC_piac_1).
VARIABLE LABELS FAC_piac_1 'Piac kultúra aggregált értéke'.

/* Descriptives of PS scores.
DESCRIPTIVES FAC_klan_1 FAC_adhok_1 FAC_hierar_1 FAC_piac_1.


/* Forming principal components - Physical.
DATASET ACTIVATE $DataSet.
FACTOR
  /VARIABLES Fizika1 Fizikai2 Fizikai3 Fizikai4
  /MISSING LISTWISE 
  /ANALYSIS Fizika1 Fizikai2 Fizikai3 Fizikai4
  /PRINT INITIAL CORRELATION KMO EXTRACTION FSCORE
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

/* 1 PC was retained.
RENAME VARIABLES (FAC1_1 = FAC_fizikai_1).
VARIABLE LABELS FAC_fizikai_1 'Fizikai élménydimenzió aggregált értéke'.

* Forming principal components - Culture.
DATASET ACTIVATE $DataSet.
FACTOR
  /VARIABLES Kultúra1 Kultúra2 Kultúra3 Kultúra4 Kultúra5 
    Kultúra6 Kultúra7 Kultúra8 Kultúra9 Kultúra10
  /MISSING LISTWISE 
  /ANALYSIS Kultúra1 Kultúra2 Kultúra3 Kultúra4 Kultúra5 
    Kultúra6 Kultúra7 Kultúra8 Kultúra9 Kultúra10
  /PRINT INITIAL CORRELATION KMO EXTRACTION FSCORE
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

/* 1 PC was retained
RENAME VARIABLES (FAC1_1 = FAC_kultura_1).
VARIABLE LABELS FAC_kultura_1 'Kultúra élménydimenzió aggregált értéke'.

* Forming principal components - Technology.
DATASET ACTIVATE $DataSet.
FACTOR
  /VARIABLES Technológia1 Technológia2 Technológia3
  /MISSING LISTWISE 
  /ANALYSIS Technológia1 Technológia2 Technológia3
  /PRINT INITIAL CORRELATION KMO EXTRACTION FSCORE
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

/* 1 PC was retained again.
RENAME VARIABLES (FAC1_1 = FAC_tech_1).
VARIABLE LABELS FAC_tech_1 'technológiai élménydimenzió aggregált értéke'.

/* Descriptives of the PC scores.
DESCRIPTIVES FAC_fizikai_1 FAC_kultura_1 FAC_tech_1.



/*Recoding variables into Kozszfera (Public) and Nonprofit.
/* Public sector.
RECODE Kéremjelöljemeghogyholdolgozik (1=1) (ELSE=0) INTO Kozszfera.
VARIABLE LABELS  Kozszfera 'Közszférában dolgozik-e?'.
EXECUTE.
/*Nonprofit sector.
RECODE Kéremjelöljemeghogyholdolgozik (3=1) (ELSE=0) INTO Nonprofit.
VARIABLE LABELS  Nonprofit 'Nonprofit szférában dolgozik-e?'.
EXECUTE.

/*Creating interactions.
/* Using Public....
COMPUTE Klan_kozszfera=FAC_klan_1 * Kozszfera.
VARIABLE LABELS Klan_kozszfera 'Közszféra és klán interakciója'. 
EXECUTE.

COMPUTE Adhokracia_kozszfera=FAC_adhok_1 * Kozszfera.
VARIABLE LABELS Adhokracia_kozszfera 'Közszféra és adhokrácia interakciója'. 
EXECUTE.

COMPUTE Hierarchia_kozszfera=FAC_hierar_1 * Kozszfera.
VARIABLE LABELS Hierarchia_kozszfera 'Közszféra és hierarchia interakciója'. 
EXECUTE.

COMPUTE Piac_kozszfera=FAC_piac_1 * Kozszfera.
VARIABLE LABELS Piac_kozszfera 'Közszféra és piac interakciója'. 
EXECUTE.

/* ...then using Nonprofit.
COMPUTE Klan_nonprofit=FAC_klan_1 * Nonprofit.
VARIABLE LABELS Klan_nonprofit 'Nonprofit és klán interakciója'. 
EXECUTE.

COMPUTE Adhokracia_nonprofit=FAC_adhok_1 * Nonprofit.
VARIABLE LABELS Adhokracia_nonprofit 'Nonprofit és adhokrácia interakciója'. 
EXECUTE.

COMPUTE Hierarchia_nonprofit=FAC_hierar_1 * Nonprofit.
VARIABLE LABELS Hierarchia_nonprofit 'Nonprofit és hierarchia interakciója'. 
EXECUTE.

COMPUTE Piac_nonprofit=FAC_piac_1 * Nonprofit.
VARIABLE LABELS Piac_nonprofit 'Nonprofit és piac interakciója'. 
EXECUTE.

/* Regression analysis.
/* Modeling the physical EX dimension (Eq. (3) in the paper):.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT FAC_fizikai_1
  /METHOD=ENTER FAC_klan_1 FAC_adhok_1 FAC_hierar_1 FAC_piac_1 Kozszfera Nonprofit Klan_kozszfera Klan_nonprofit Adhokracia_kozszfera Adhokracia_nonprofit Hierarchia_kozszfera Hierarchia_nonprofit Piac_kozszfera Piac_nonprofit
   /SCATTERPLOT=(*ZRESID ,*ADJPRED)
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID).

/* Modeling the technological EX dimension (Eq. (4) in the paper).
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT FAC_tech_1
  /METHOD=ENTER FAC_klan_1 FAC_adhok_1 FAC_hierar_1 FAC_piac_1 Kozszfera Nonprofit Klan_kozszfera Klan_nonprofit Adhokracia_kozszfera Adhokracia_nonprofit Hierarchia_kozszfera Hierarchia_nonprofit Piac_kozszfera Piac_nonprofit
   /SCATTERPLOT=(*ZRESID ,*ADJPRED)
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID).

/* Modeling the cultural EX dimension (Eq. (5) in the paper).
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT FAC_kultura_1
  /METHOD=ENTER FAC_klan_1 FAC_adhok_1 FAC_hierar_1 FAC_piac_1 Kozszfera Nonprofit Klan_kozszfera Klan_nonprofit Adhokracia_kozszfera Adhokracia_nonprofit Hierarchia_kozszfera Hierarchia_nonprofit Piac_kozszfera Piac_nonprofit
  /SCATTERPLOT=(*ZRESID ,*ADJPRED)
  /SAVE ADJPRED ZRESID
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID).



/* Saving the data into Excel.
SAVE TRANSLATE OUTFILE='C:\Users\Jenő\Desktop\ELTE\2024 ősz - GTK\Egyebek\Laurának segítség\PCA_and_interactions_FINAL.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=VALUES
  /REPLACE.

/* And into sav.
SAVE OUTFILE='C:\Users\Jenő\Desktop\ELTE\2024 ősz - GTK\Egyebek\Laurának segítség\PCA_and_interactions_FINAL.sav'
  /COMPRESSED.

/* Correlation matrices.
DATASET ACTIVATE $DataSet.
CORRELATIONS
  /VARIABLES=Klán1 Adhok1 Hierar1 Piac1 Klán2 Adhok2 Hierar2 Piac2 Klán3 Adhok3 Hierar3 Piac3 Klán4 
    Adhok4 Hierar4 Piac4 Klán5 Adhok5 Hierar5 Piac5 Klán6 Adhok6 Hierar6 Piac6 Klán7 Adhok7 Hierar7 
    Piac7
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.


CORRELATIONS
  /VARIABLES=Fizika1 Fizikai2 Fizikai3 Fizikai4 Kultúra1 Kultúra2 Kultúra3 Kultúra4 Kultúra5 
    Kultúra6 Kultúra7 Kultúra8 Kultúra9 Kultúra10 Technológia1 Technológia2 Technológia3
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.



