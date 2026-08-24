(* ::Package:: *)

BeginPackage["FlaSR`"];


FlaSRHelp::usage="FlaSRHelp[function] prints extended documentation on a FlaSR function's arguments, options, and outputs.";
FlaSRHelp::details=
"Arguments:
function (Symbol): The name of a function from the FlaSR Mathematica package."

startPythonSession::usage="startPythonSession[session,path] checks for a valid Python session and file path and loads in the Python file.";
startPythonSession::details=
"Arguments:
session (ExternalSessionObject): An active external Python session.
path (String): Path to the FlaSR.py Python file.

Returns:
An ExternalFunction object indicating the FlaSR.py file has been loaded into the Python session."

generateASRs::usage="generateASRs[in,h,out] finds amplitudes and amplitude sum rules (ASRs) for a given system.";
generateASRs::details=
"Arguments:
in (List): Contains U-spins (Real) or particle multiplets (List of Strings) in the incoming state.
h (List): Contains U-spins (Real) or coefficients (List of Symbols) in the Hamiltonian.
out (List): Contains U-spins (Real) or particle multiplets (List of Strings) in the outgoing state.

Options:
phys (True|False): Indicates whether function arguments contain U-spins (False) or particle multiplets/Hamiltonian factors (True). Default: phys->False.

Returns:
system (Association): All information about the system's representations, amplitudes, and ASRs. Keys and values:
- \"Irreps\" (List): Inputted U-spin representations (List of Reals) in {{in reps}, {H rep}, {out reps}} format.
- \"Multiplets\" (List): Inputted multiplets (List of Strings) and factors (List of Symbols) in {{in multiplets}, {H factors}, {out multiplets}} format for physical systems. Empty when phys->False.
- \"n doublets\" (Real): Number of would-be doublets.
- \"p factor\" (Real): (-1)^p factor for defining a/s-type amplitudes.
- \"n amps\" (Real): Number of amplitudes in the system.
- \"Amplitudes\" (List): Contains an Association for each amplitude pair in the system. Keys and values:
	- \"Process\" (List): Contains physical processes (String) for an amplitude and its U-spin conjugate. Only available for physical systems.
	- \"QN label\" (List): Contains m quantum number labels (String), where m is the third component of U-spin, for an amplitude and its U-spin conjugate.
	- \"n-tuple\" (List): Contains n-tuple labels (String) for an amplitude and its U-spin conjugate. n-tuples represent amplitudes as comma-separated tuples of substrings, where each substring is comprised of '-'s and '+'s and encodes the u and m QNs of a component of a participating multiplet. Signs are inverted for initial state and Hamiltonian components.
	- \"Coord\" (String): Coordinate (String) for an amplitude pair in the lattice used to derive sum rules.
	- \"Binary index\" (List): Contains binary indices (Real), written in base 10, for an amplitude and its U-spin conjugate. Indices are derived by converting the n-tuples into binary numbers through '-' <-> 0 and '+' <-> 1 and removing commas.
	- \"mu\" (Real): mu-factor for the coordinate in the lattice used to derive sum rules.
	- \"CG\" (Real): Clebsch-Gordan coefficient from symmetrization for systems without doublets. Equal to 1 for all amplitudes for a system with at least one doublet.
	- \"CKM\" (List): Contains weak interaction factors (Expression) from the Hamiltonian. Only appears for physical systems.
- \"n ASRs\" (List): Contains the number of amplitude sum rules (Real) found at each order of breaking.
- \"ASRs\" (List): Contains matrices of amplitude sum rule coefficients (Real) listed by order of breaking.";

findA2SRMat::usage="findA2SRMat[ASRMat] finds the A2SR matrix for a given ASR matrix.";
findA2SRMat::usage=
"Arguments:
ASRMat (List): Matrix of ASR coefficients.

Returns:
A2SRMat (List): Matrix of A2SR coefficients derived from the ASR matrix. Note: this assumes differential observables.";

generateSRs::usage="generateSRs[in,h,out] finds amplitudes, amplitude sum rules (ASRs), and amplitude-squared sum rules (A2SRs) for a given system.";
generateSRs::details=
"Arguments:
in (List): Contains U-spins (Real) or particle multiplets (List of Strings) in the incoming state.
h (List): Contains U-spins (Real) or coefficients (List of Symbols) in the Hamiltonian.
out (List): Contains U-spins (Real) or particle multiplets (List of Strings) in the outgoing state.

Options:
phys (True|False): Indicates whether function arguments contain U-spins (False) or particle multiplets/Hamiltonian factors (True). Default: phys->False.
obs (\"Diff\"|\"Int\"): Indicates whether A2SRs should be treated as the sum rules between differential (\"Diff\") or integrated (\"Int\") observables. Only in effect when phys->True. Default: obs->\"Diff\".

Returns:
system (Association): All information about the system's representations, amplitudes, ASRs, and A2SRs. Keys and values:
- \"Irreps\" (List): Inputted U-spin representations (List of Reals) in {{in reps}, {H rep}, {out reps}} format.
- \"Multiplets\" (List): Inputted multiplets (List of Strings) and factors (List of Symbols) in {{in multiplets}, {H factors}, {out multiplets}} format for physical systems. Empty when phys->False.
- \"n doublets\" (Real): Number of would-be doublets.
- \"p factor\" (Real): (-1)^p factor for defining a/s-type amplitudes.
- \"n amps\" (Real): Number of amplitudes in the system.
- \"Amplitudes\" (List): Contains an Association for each amplitude pair in the system. Keys and values:
	- \"Process\" (List): Contains physical processes (String) for an amplitude and its U-spin conjugate. Only available for physical systems.
	- \"QN label\" (List): Contains m quantum number labels (String), where m is the third component of U-spin, for an amplitude and its U-spin conjugate.
	- \"n-tuple\" (List): Contains n-tuple labels (String) for an amplitude and its U-spin conjugate. n-tuples represent amplitudes as comma-separated tuples of substrings, where each substring is comprised of '-'s and '+'s and encodes the u and m QNs of a component of a participating multiplet. Signs are inverted for initial state and Hamiltonian components.
	- \"Coord\" (String): Coordinate (String) for an amplitude pair in the lattice used to derive sum rules.
	- \"Binary index\" (List): Contains binary indices (Real), written in base 10, for an amplitude and its U-spin conjugate. Indices are derived by converting the n-tuples into binary numbers through '-' <-> 0 and '+' <-> 1 and removing commas.
	- \"mu\" (Real): mu-factor for the coordinate in the lattice used to derive sum rules.
	- \"CG\" (Real): Clebsch-Gordan coefficient from symmetrization for systems without doublets. Equal to 1 for all amplitudes for a system with at least one doublet.
	- \"CKM\" (List): Contains weak interaction factors (Expression) from the Hamiltonian. Only appears for physical systems.
	- \"Integrated channel ID\" (List): Contains numbers (Real) enumerating unique integrated channels by the order in which they appear in the amplitude table. Only appears for physical systems with obs->\"Int\".
- \"n ASRs\" (List): Contains the number of amplitude sum rules (Real) found at each order of breaking.
- \"ASRs\" (List): Contains matrices of amplitude sum rule coefficients (Real) listed by order of breaking.
- \"n A2SRs\" (List): Contains the number of amplitude-squared sum rules (Real) found at each order of breaking.
- \"A2SRs\" (List): Contains matrices of amplitude-squared sum rule coefficients (Real) listed by order of breaking.
- \"SR extract\" (List): Contains sum rule coefficient matrices at the selected b. If only ampType (amp2Type) is specified, contains only ASR (A2SR) coefficients. If both ampType and amp2Type are specified, contains A2SR coefficients. Initialized to None by generateSRs and redefined after running printSystem.
- \"Amp vector\" (List): Either is a vector of formatted A-type amplitudes (or |A\!\(\*SuperscriptBox[\(|\), \(2\)]\) amplitudes-squared) (Symbols) or contains vectors of formatted a/s-type amplitudes (or \[CapitalDelta]/\[CapitalSigma]-type amplitudes-squared) (List of Symbols) for the system. Initialized to None by generateSRs and redefined after running printSystem.";

numAmps::usage="numAmps[system,nPairs:False] returns the total number of amplitudes (or amplitude pairs) in the system.";
numAmps::details=
"Arguments:
system (Association): A system association. See the documentation for generateSRs for details.

Options:
nPairs (True|False): Indicates whether to return the number of amplitudes (False) or amplitude pairs (True). Default: nPairs: False.

Returns:
The total number of amplitudes (or amplitude pairs) in the system (Real).";

labelAmps::usage="labelAmps[system,colName,labels] modifies system to add a column of user-defined labels to system[[\"Amplitudes\"]]."
labelAmps::details=
"Arguments:
system (Association): A system association. See the documentation for generateSRs for details.
colName (String): Name of new column to add to amplitude table.
labels (List): Contains labels (String) for each amplitude (or amplitude pair) in the order of appearance in the amplitude table. Number of labels must equal number of amplitudes (or amplitude pairs).

Options:
labeling (String): Labeling mode to indicate whether user is labeling single amplitudes (\"Amplitudes\") or amplitude pairs (\"Amplitude pairs\"). Default: labeling->\"Amplitudes\".

Returns:
system[[\"Amplitudes\"]] (List): The modified amplitude table which includes a new column of user-defined labels. New/modified keys and values of amplitudes associations:
- colName (List|Any): Either contains user-defined labels (Any) for an amplitude and its U-spin conjugate or a single label (Any) for an amplitude pair.";

unlabelAmps::usage="unlabelAmps[system,colNames] modifies system to remove column(s) from system[[\"Amplitudes\"]]."
unlabelAmps::details=
"Arguments:
system (Association): A system association. See the documentation for generateSRs for details.
colNames (String|List): Name(s) of column(s) to remove from amplitude table.

Returns:
system[[\"Amplitudes\"]] (List): The modified amplitude table from which the specified column(s) have been removed.";

printAmps::usage="printAmps[system] prints the system's amplitudes and definitions for a/s-type amplitudes and \[CapitalDelta]/\[CapitalSigma]-type amplitudes-squared.";
printAmps::details=
"Arguments:
system (Association): A system association. See the documentation for generateSRs for details.

Options:
showFactors (True|False): Indicates whether to print internal calculation factors from the sum rule algorithm in the amplitude table (True) or not (False). Default: showFactors->False.";

numSRs::usage="numSRs[system,squared:False] returns the number of amplitude (or amplitude-squared) sum rules found at each order of breaking.";
numSRs::details=
"Arguments:
system (Association): A system association. See the documentation for generateSRs for details.

Options:
squared (True|False): Indicates whether to return counts of amplitude (False) or amplitude-squared (True) sum rules. Default: squared: False.
b (All|Real|List): Breaking order(s) at which to print sum rules. User can print sum rules to all possible orders of breaking (All), at a particular order (Real, 0 <= b <= highest order of breaking), or over a range of orders of breaking ({start b (min: 0), end b (max: highest order of breaking, or All), increment}). Default: b->All.

Returns:
Number of amplitude (or amplitude-squared) sum rules found at each order of breaking (List of Reals).";

printSRs::usage="printSRs[system,ampType->{a,s}/{A} OR amp2Type->{\[CapitalDelta],\[CapitalSigma]}/{A}] prints amplitude (or amplitude-squared) sum rules at each order of breaking and extracts the formatted sum rule matrices and amplitude vector(s) for manipulation.";
printSRs::details=
"Arguments:
system (Association): A system association. See the documentation for generateSRs for details.

Options:
ampType (List): Contains 1 or 2 symbol(s) to select amplitude type. Convention is to set ampType->{A} for A-type amplitudes and ampType->{a,s} for a/s-type amplitudes. Default: ampType->None. Note: only one of ampType or amp2Type should be specified to print either ASRs or A2SRs; if both are specified, printSRs will print A2SRs by default.
amp2Type (List): Contains 1 or 2 symbol(s) to select squared amplitude type. Convention is to set amp2Type->{A} for |A\!\(\*SuperscriptBox[\(|\), \(2\)]\) amplitudes-squared and amp2Type->{\[CapitalDelta],\[CapitalSigma]} for \[CapitalDelta]/\[CapitalSigma]-type amplitudes-squared. Default: amp2Type->None. Note: only one of ampType or amp2Type should be specified to print either ASRs or A2SRs; if both are specified, printSRs will print A2SRs by default.
ampFormat (String): Labeling convention for displaying amplitudes. Options are physical process names (\"Process\", only available for A-type amps), m quantum numbers (\"QN label\"), n-tuples (\"n-tuple\"), coordinate notation (\"Coord\", only available for a/s-type amps), binary indices (\"Binary index\"), or user-defined labels for a column of the amplitude table (name of custom column). Default: ampFormat->\"n-tuple\" unless the system is a physical system, in which case ampFormat->\"Process\".
showSRs (True|False): Indicates whether to print sum rules. Default: showSRs->True.
expandSRs (True|False): Indicates whether to display each row of a sum rules matrix as an expanded algebraic expression of amplitudes (True) or to keep each row as a list of coefficients (False). Default: expandSRs->False.
CKM (True|False): Indicates whether to include CKM factors in the sum rules. Default: CKM->False.
b (All|Real|List): Breaking order(s) at which to print sum rules. User can print sum rules to all possible orders of breaking (All), at a particular order (Real, 0 <= b <= highest order of breaking), or over a range of orders of breaking ({start b (min: 0), end b (max: highest order of breaking, or All), increment}). Default: b->All.
amp2Quad (True|False): Indicates whether the symbol in amp2Type is quadratically (True) or linearly (False) dependent on A. Default: amp2Quad->False.

Returns:
system[[\"SR extract\"]] (List): Modified value of the \"SR extract\" key to the system association. Contains sum rule coefficient matrices at the selected b. If only ampType (amp2Type) is specified, contains only ASR (A2SR) coefficients. If both ampType and amp2Type are specified, contains A2SR coefficients.
Other modified keys and values of the system assocation:
- \"Amp vector\" (List): Either is a vector of formatted A-type amplitudes (or |A\!\(\*SuperscriptBox[\(|\), \(2\)]\) amplitudes-squared) (Symbols) or contains vectors of formatted a/s-type amplitudes (or \[CapitalDelta]/\[CapitalSigma]-type amplitudes-squared) (List of Symbols) for the system.";

printSystem::usage="printSystem[system,ampType->{a,s}/{A}, amp2Type->{\[CapitalDelta],\[CapitalSigma]}/{A}] prints information about the system's representations, amplitudes, and sum rules and adds formatted sum rules and amplitude vectors to the system association.";
printSystem::details=
"Arguments:
system (Association): A system association. See the documentation for generateSRs for details.

Options:
showReps (True|False): Indicates whether to print the system summary. Default: showReps->True.
-----
showAmps (True|False): Indicates whether to print the amplitude table. Default: showAmps->True.
showFactors (True|False): Indicates whether to print internal calculation factors from the sum rule algorithm in the amplitude table (True) or not (False). Default: showFactors->False.
-----
showASRs (True|False): Indicates whether to print ASRs. Default: showASRs->True. Note: while both ampType and amp2Type can be separately specified, the other formatting options (e.g., ampFormat) will be shared for printing both ASRs and A2SRs.
showA2SRs (True|False): Indicates whether to print A2SRs. Default: showA2SRs->True. Note: while both ampType and amp2Type can be separately specified, the other formatting options (e.g., ampFormat) will be shared for printing both ASRs and A2SRs.
ampType (List): Contains 1 or 2 symbol(s) to select amplitude type. Convention is to set ampType->{A} for A-type amplitudes and ampType->{a,s} for a/s-type amplitudes. Default: ampType->None. Note: only one of ampType or amp2Type should be specified to print either ASRs or A2SRs; if both are specified, printSRs will print A2SRs by default.
amp2Type (List): Contains 1 or 2 symbol(s) to select squared amplitude type. Convention is to set amp2Type->{A} for |A\!\(\*SuperscriptBox[\(|\), \(2\)]\) amplitudes-squared and amp2Type->{\[CapitalDelta],\[CapitalSigma]} for \[CapitalDelta]/\[CapitalSigma]-type amplitudes-squared. Default: amp2Type->None. Note: only one of ampType or amp2Type should be specified to print either ASRs or A2SRs; if both are specified, printSRs will print A2SRs by default.
ampFormat (String): Labeling convention for displaying amplitudes. Options are physical process names (\"Process\", only available for A-type amps), m quantum numbers (\"QN label\"), n-tuples (\"n-tuple\"), coordinate notation (\"Coord\", only available for a/s-type amps), binary indices (\"Binary index\"), or user-defined labels for a column of the amplitude table (name of custom column). Default: ampFormat->\"n-tuple\" unless the system is a physical system, in which case ampFormat->\"Process\".
expandSRs (True|False): Indicates whether to display each row of a sum rules matrix as an expanded algebraic expression of amplitudes (True) or to keep each row as a list of coefficients (False). Default: expandSRs->False.
CKM (True|False): Indicates whether to include CKM factors in the sum rules. Default: CKM->False.
b (All|Real|List): Breaking order(s) at which to print sum rules. User can print sum rules to all possible orders of breaking (All), at a particular order (Real, 0 <= b <= highest order of breaking), or over a range of orders of breaking ({start b (min: 0), end b (max: highest order of breaking, or All), increment}). Default: b->All.
amp2Quad (True|False): Indicates whether the symbol in amp2Type is quadratically (True) or linearly (False) dependent on A. Default: amp2Quad->False.

Returns:
system (Association): The inputted system association, modified to include formatted sum rule coefficient matrices and amplitude vector(s). Modified keys and values:
- \"SR extract\" (List): Contains sum rule coefficient matrices at the selected b. If only ampType (amp2Type) is specified, contains only ASR (A2SR) coefficients. If both ampType and amp2Type are specified, contains A2SR coefficients.
- \"Amp vector\" (List): Either is a vector of formatted A-type amplitudes (or |A\!\(\*SuperscriptBox[\(|\), \(2\)]\) amplitudes-squared) (Symbols) or contains vectors of formatted a/s-type amplitudes (or \[CapitalDelta]/\[CapitalSigma]-type amplitudes-squared) (List of Symbols) for the system.";


Begin["`Private`"];


FlaSRHelp[function_Symbol]:=Module[{usage, details},
usage=Quiet[MessageName[function,"usage"]];
details=Quiet[MessageName[function,"details"]];

If[StringQ[usage],
(Print[usage];
If[StringQ[details],Print[details]];
),
Print["No documentation found for ",function,"."];
];
];


$FlaSRSession=.;


startPythonSession[session_,path_String]:=Module[{},
$FlaSRSession=If[MatchQ[session,_ExternalSessionObject],session,Message[startPythonSession::nosession];Return[$Failed]];
If[FileExistsQ[path],Null,Message[startPythonSession::nofile,path];Return[$Failed]];

ExternalEvaluate[$FlaSRSession,File[path]]
];

startPythonSession::nosession="No active Python session provided.";
startPythonSession::nofile="File `1` does not exist.";


(* Wrapper function for using ExternalEvaluate in the active Python session *)
pyEval[expr_,args_:<||>]:=ExternalEvaluate[$FlaSRSession,<|"Command"->expr,"Arguments"->args|>];


(* Extracts amplitudes from system (a Python System object) *)
Options[extractAmps]={partVal->{}};
extractAmps[system_,OptionsPattern[]]:=Module[{amplitudes,colNames,extractParticles,partVal=OptionValue[partVal]},
amplitudes=pyEval["System.extract_amps",system];
colNames={"Process","QN label","n-tuple","Coord","Binary index","q factor","mu","CG"};
amplitudes=Map[AssociationThread[colNames,#]&]@amplitudes;
amplitudes[[All,"Multiplet components"]]=Map[{#[[1]],#[[3]]}&,amplitudes[[All,"Process"]],{2}];

(* Processes from particle names *)
extractParticles[particles_,indices_]:=MapThread[MapThread[Part,{#1,#2}]&,{particles,indices}];
If[Length[partVal]>0,
(amplitudes[[All,"Process"]]=Map[{extractParticles[partVal,#[[1]]],extractParticles[partVal,#[[2]]]}&,amplitudes[[All,"Process"]]];
amplitudes[[All,"CKM"]]=Map[#[[2]]&,amplitudes[[All,"Process"]],{2}];
amplitudes[[All,"Process"]]=Map[{#[[1]],#[[3]]}&,amplitudes[[All,"Process"]],{2}];
amplitudes[[All,"Process"]]=Map[StringRiffle,amplitudes[[All,"Process"]],{-2}];
amplitudes[[All,"Process"]]=Map[{StringJoin[#[[1]]," \[Rule] ",#[[2]]]}&,amplitudes[[All,"Process"]],{2}];
amplitudes[[All,"Process"]]=Flatten/@amplitudes[[All,"Process"]];
),
amplitudes=KeyDrop[#,"Process"]&/@amplitudes;
];

amplitudes[[All,"QN label"]]=Map[If[#>0,"+"<>ToString[Rationalize[#],StandardForm],ToString[Rationalize[#],StandardForm]]&,amplitudes[[All,"QN label"]],{-1}];
amplitudes[[All,"QN label"]]=Map[StringRiffle,amplitudes[[All,"QN label"]],{-2}];
amplitudes[[All,"QN label"]]=Map[{StringJoin[#[[1]],ToString[Overscript[" \[Rule] ",#[[2]]],StandardForm],#[[3]]]}&,amplitudes[[All,"QN label"]],{2}];
amplitudes[[All,"QN label"]]=Flatten/@amplitudes[[All,"QN label"]];

amplitudes[[All,"mu"]]=Map[Sqrt[#[[1]]]*#[[2]]&,amplitudes[[All,"mu"]]]; (* mu factors *)
amplitudes[[All,"CG"]]=Map[ClebschGordan@@Rationalize[#]&,amplitudes[[All,"CG"]]]; (* CG coeffs from symmetrization *)
amplitudes
];


(* Constructs a Python System object and lists the multiplet contents for physical systems *)
defineSystem[in_,h_,out_,phys_]:=Module[{repSpins,reps,system,particles,n},
repSpins[list_]:=Table[(Length[list[[i]]]-1)/2,{i,Length[list]}];

If[phys,
(particles={in,h,out};
reps=Map[repSpins,particles];
),
(reps={in,h,out};
particles={};
)
];

n=Total[2*Flatten@reps];
If[EvenQ[n],Null,Message[defineSystem::argx,n];Return[$Failed]];

system=pyEval["define_system",{reps,phys}];
{system,particles}
];

defineSystem::argx="Invalid input. Number of would-be doublets is `1`. Please enter a system with an even number of doublets.";


(* Divides out common factors in matrix rows *)
simplifyFactors[mat_]:=(#/(If[Positive[DeleteCases[#,0][[1]]],1,-1]*Sqrt[Apply[GCD,DeleteCases[#,0]^2]]))&/@Cases[mat,Except@{0..}];


(* Sets a matrix column to 0 *)
setMatColToZero[mat_,col_]:=Module[{matVal=mat},
matVal=If[matVal=={},
{},
(matVal[[All,col]]=0;
matVal)
]
];


Options[generateASRs]={phys->False};
generateASRs[in_,h_,out_,OptionsPattern[]]:=Module[{system,phys=OptionValue[phys],particles,aux,ASRs,amplitudes,dupPairs,factorsMat,irreps,n,p,indices,selfConj,nAmps,nASRs},
{system,particles}=defineSystem[in,h,out,phys]; (* constructs Python System object *)

aux=pyEval["System.extract_sys",system][[1]];

{system,ASRs,dupPairs}=pyEval["generate_srs",system]; (* M values for symmetrized system, contains duplicate amplitudes *)
amplitudes=extractAmps[system];

factorsMat=DiagonalMatrix[amplitudes[[All,"q factor"]]*amplitudes[[All,"mu"]]*amplitudes[[All,"CG"]]]; (* ASR matrices include q factors *)
ASRs=Map[# . factorsMat&,ASRs]; (* SRs for symmetrized system *)

(* Correct for duplicate amplitudes from symmetrization *)
Do[ASRs[[b]][[All,dupPairs[[All,1]]]]+=ASRs[[b]][[All,dupPairs[[All,2]]]],{b,Length[ASRs]}]; (* adds together cols of duplicate amp pairs *)
ASRs=Transpose[Delete[Transpose[#],List/@dupPairs[[All,2]]]]&/@ASRs; (* deletes duplicate cols *)
system=pyEval["System.remove_dups",{system,dupPairs}];
amplitudes=extractAmps[system,partVal->particles];

{irreps,n,p}=pyEval["System.extract_sys",{system,True}][[2;;]];
amplitudes=KeyDrop[#,"q factor"]&/@amplitudes;

(* Set identically 0 amplitude columns to 0 *)
indices=amplitudes[[All,"Binary index"]];
selfConj=Table[If[indices[[i,1]]==indices[[i,2]],i,Nothing],{i,Length[indices]}];
If[Length[selfConj]>0,
ASRs=MapIndexed[If[#1=={},
{},
If[(p==1)==OddQ[First[#2]], (* if p==1, a (odd) is 0, otherwise s (even) is 0 *)
setMatColToZero[#1,selfConj[[1]]],
#1
]
]&,
ASRs
]
];
ASRs=If[aux,Map[RowReduce,ASRs],Map[simplifyFactors,ASRs]]; (* simplifies factors, row reduces for systems requiring symmetrization to remove redundant SRs *)
ASRs=Map[Cases[Except@{0..}],ASRs];

system=<|"Amplitudes"->amplitudes,"ASRs"->ASRs|>; (* from here on, system is an association *)
nAmps=numAmps[system];
nASRs=numSRs[system];
system=<|"Irreps"->irreps,"Multiplets"->particles,"n doublets"->n,"p factor"->p,"n amps"->nAmps,"Amplitudes"->amplitudes,"n ASRs"->nASRs,"ASRs"->ASRs|>;

system
];


findA2SRMat[ASRMat_]:=Module[{ASRMatRR,pivotCols,freeCols,freeMat,groupedIndices,indices,colPairs,xMat,xMatNullSpace,groupedA2SR,A2SRMat},
If[ASRMat=={},
A2SRMat={},
(ASRMatRR=RowReduce[ASRMat];

pivotCols=Map[Position[#,1][[1,1]]&,ASRMatRR];
freeCols=Complement[Range[Length[Transpose[ASRMatRR]]],pivotCols];
freeMat=ASRMatRR[[All,freeCols]]; (* extracts the free cols of an ASR matrix *)

groupedIndices=Join[pivotCols,freeCols];
indices=Table[Position[groupedIndices,i][[1,1]],{i,Length[groupedIndices]}]; (* value at the ith position gives the col of the grouped matrix corresponding to the original ith col *)

If[Dimensions[freeMat][[2]]>=2,
(* case with cross terms: find null space of cross terms matrix *)
(colPairs=Subsets[Transpose[freeMat],{2}]; (* list of all unique column pairs *)
xMat=Transpose@Map[Times@@#&,colPairs]; (* cross terms matrix: cols are pairwise multiples of free cols *)
xMatNullSpace=NullSpace[Transpose@xMat]; (* xMatNullSpace.xMat = 0; i.e., left mult of cross terms mat by null space mat sets cross terms to 0 *)

groupedA2SR=If[xMatNullSpace=={},{},Join[xMatNullSpace,-xMatNullSpace . (freeMat^2),2]]; (* multiplies free cols by xMatNullSpace and brings back to LHS *)
),
(* case with no cross terms: A^2SR has the trivial form s^2-s^2 = 0 *)
(xMat={{0}};
groupedA2SR=Join[IdentityMatrix[Length[ASRMatRR]],-(freeMat^2),2];
)
];

A2SRMat=If[groupedA2SR=={},{},Transpose@Table[Transpose[groupedA2SR][[indices[[i]]]],{i,Length[indices]}]]; (* rearranges A^2SR mat into original order *)
)
];

A2SRMat
];


Options[generateSRs]={phys->False,obs->"Diff"};
generateSRs[in_,h_,out_,opts:OptionsPattern[]]:=Module[{system,phys=OptionValue[phys],obs=OptionValue[obs],keepMatchingSRs,noDoublets,ASRs,A2SRs,integrateA2SRs,indices,selfConjs,nA2SRs},
system=generateASRs[in,h,out,Sequence@@FilterRules[{opts},Options[generateASRs]]];
(* Find A2SRs for given ASRs and checks for required matching sum rules for no-doublets cases *)
keepMatchingSRs[matList_,i_]:=Module[{mat,lowerMat},
mat=matList[[i]];
lowerMat=matList[[i-1]];

If[(lowerMat=={})||(mat=={}),
{},
(lowerMat=Transpose[NullSpace[lowerMat]];
If[lowerMat=={},{},Pick[mat,Map[MatchQ[#,{0..}]&,mat . lowerMat],True]]
)
]
]; (* keeps rows in the order b matrix within the row space of the b-1 matrix *)

noDoublets=!AnyTrue[Flatten@system[["Irreps"]],#==(1/2)&];
ASRs=system[["ASRs"]];
If[noDoublets,
ASRs=MapIndexed[If[EvenQ[#2[[1]]-1]&&(#2[[1]]-1>=2),keepMatchingSRs[ASRs,#2[[1]]],#1]&,ASRs]
]; (* for no-doublets cases: for ASR matrices with even b >= 2, remove rows not in the row space of the b-1 ASR matrix *)

A2SRs=findA2SRMat/@ASRs; (* squaring procedure *)
If[noDoublets,
A2SRs=MapIndexed[If[OddQ[#2[[1]]-1]&&(#2[[1]]-1>=3),keepMatchingSRs[A2SRs,#2[[1]]],#1]&,A2SRs]
]; (* for no-doublets cases: for A2SR matrices with odd b >= 3, remove rows not in the row space of the b-1 A2SR matrix *)



(* Diff and int observables *)
integrateA2SRs[]:=Module[{inMulti,outMulti,ampIndices,uniqueInMulti,uniqueOutMulti,uniqueKeyPosInMulti,uniqueKeyPosOutMulti,formIndexPairs,ampIndexPairs,uniqueAmps,intChannelIDs,convertToAmpPairs,negCols,identicalColGroups,negMatCols,integrateA2SRMat},
(* List out amplitudes as {{unique in multiplet key index, component},{unique out multiplet key index, component}}. Use this to associate unique amplitudes to indices of all single amplitudes corresponding to a given amplitude. *)
inMulti=system[["Multiplets"]][[1]]; (* list of inputted multiplets *)
outMulti=system[["Multiplets"]][[3]];
ampIndices=Flatten[system[["Amplitudes"]][[All,"Multiplet components"]],1]; (* list all amps as {{in multi components},{out multi components}} *)

uniqueInMulti=PositionIndex[inMulti]; (* assoc of all unique in state multiplets, {multiplet} -> {i within inputted in state multiplet list} *)
uniqueOutMulti=PositionIndex[outMulti];
uniqueKeyPosInMulti=Map[Position[Keys[uniqueInMulti],#][[1,1]]&,inMulti]; (* i of inputted multiplets within unique in state multiplet keys *)
uniqueKeyPosOutMulti=Map[Position[Keys[uniqueOutMulti],#][[1,1]]&,outMulti];

formIndexPairs[{ampIn_,ampOut_}]:={MapIndexed[{uniqueKeyPosInMulti[[#2]][[1]],#1}&,ampIn],MapIndexed[{uniqueKeyPosOutMulti[[#2]][[1]],#1}&,ampOut]};
ampIndexPairs=formIndexPairs/@ampIndices; (* amp indices list becomes {unique multiplet key index, component} list *)

uniqueAmps=PositionIndex[Map[({#[[1]],Sort[#[[2]]]})&,ampIndexPairs]]; (* assoc of unique amp {{in keys and components},{out keys and components}} -> index of col in |A|^2 sr matrices. initial states are exact matches, final states up to permutations *)


(* Assign integrated channel IDs to amplitudes *)
intChannelIDs=ConstantArray[0,Length[ampIndexPairs]];
MapIndexed[(intChannelIDs[[#1]]=#2[[1]])&,Values[uniqueAmps]];
intChannelIDs=ArrayReshape[intChannelIDs,{Length[ampIndexPairs]/2,2}]; (* channels enumerated in order of appearance in amp table *)
system[["Amplitudes"]][[All,"Integrated channel ID"]]=intChannelIDs; (* assigns an integrated channel ID to each amplitude *)


(* Form list of amp pair cols to negate in \[CapitalDelta] matrices (negCols), list of groups of amp pair cols to combine (identicalColGroups), and association of unique amp pair col -> k! (uniqueAmps) *)
convertToAmpPairs[uniqueAmps_]:=Module[{ampAssoc=uniqueAmps,ampPairIndices,colList},
ampAssoc=Select[ampAssoc,OddQ[First[#]]&]; (* keep only cases with lower amps as first elements *)
ampPairIndices[indices_]:=Module[{pairs=Ceiling[indices/2],keepQ},
keepQ=MapIndexed[
Function[{i,idx},
OddQ[i]||idx[[1]]==1||pairs[[idx[[1]]]]!=pairs[[idx[[1]]-1]] (* keep lower amps, first elem, conj amps of unique amp pairs *)
],
indices
];
{Pick[pairs,keepQ],Pick[pairs,MapThread[EvenQ[#1]&&#2&,{indices,keepQ}]]} (* {unique amp pairs, neg cols} *)
];
ampAssoc=ampPairIndices/@ampAssoc;
colList=Flatten@Values[ampAssoc][[All,2]];
ampAssoc=#[[1]]&/@ampAssoc;
{ampAssoc,colList}
];
{uniqueAmps,negCols}=convertToAmpPairs[uniqueAmps]; (* uniqueAmps indices now refer to pairs, negCols indicate which cols need to be negated for delta matrices *)

identicalColGroups=Select[Values[uniqueAmps],Length[#]>1&]; (* list of groups of identical cols, cols refer to amp pairs now *)

uniqueAmps=#[[1]]&/@uniqueAmps;
uniqueAmps=AssociationMap[Reverse,uniqueAmps];
uniqueAmps=(Times@@Factorial[Values[Counts[#[[2]]]]])&/@uniqueAmps; (* assoc with unique col -> k! *)


(* Negate cols in \[CapitalDelta] matrices that need to be negated, then combine identical cols and scale them by their k! factors *)
negMatCols[A2SRMat_]:=Module[{negMatCol,newA2SRMat},
negMatCol[matTranspose_,col_]:=Module[{m=matTranspose},m[[col]]=-1*m[[col]];m];
newA2SRMat=If[A2SRMat=={},{},Fold[negMatCol,Transpose@A2SRMat,negCols]]; (* multiply neg cols by -1 *)

Transpose@newA2SRMat
];

integrateA2SRMat[A2SRMat_]:=Module[{addMatCols,scaleMatCol,newA2SRMat},
addMatCols[mat_,cols_]:=Module[{m=mat},m[[All,cols[[1]]]]=Total[m[[All,cols]],{2}];m];
scaleMatCol[matTranspose_,col_]:=Module[{m=matTranspose},m[[col]]=uniqueAmps[col]*m[[col]];m];

If[A2SRMat=={},
newA2SRMat={},
(newA2SRMat=A2SRMat;
newA2SRMat=Fold[addMatCols,newA2SRMat,identicalColGroups]; (* combine identical cols *)
newA2SRMat=Transpose@Fold[scaleMatCol,Transpose@newA2SRMat,Keys[uniqueAmps]]; (* multiply unique cols by k! *)
newA2SRMat=newA2SRMat[[All,Keys[uniqueAmps]]]; (* keep only unique cols *)
)
];

newA2SRMat
];

A2SRs=MapAt[negMatCols,A2SRs,List/@Range[1,Length[A2SRs],2]]; (* multiply neg cols in delta matrices by -1 *)
A2SRs=integrateA2SRMat/@A2SRs;
A2SRs=Map[If[#=={},{},Cases[RowReduce@#,Except@{0..}]]&,A2SRs];
system[["Unique amp pairs"]]=Keys[uniqueAmps]; (* temporarily add unique amp pairs key to system assoc *)
];

If[phys&&(obs==="Int"),integrateA2SRs[]];



(* Set identically 0 amplitude-squared columns to 0 *)
indices=If[phys&&(obs==="Int"),
system[["Amplitudes",system[["Unique amp pairs"]]]][[All,"Integrated channel ID"]],
system[["Amplitudes"]][[All,"Binary index"]]
];
selfConjs=Table[If[indices[[i,1]]==indices[[i,2]],i,Nothing],{i,Length[indices]}]; (* includes fake self-conjs in int obs case *)
If[Length[selfConjs]>0,
A2SRs=MapIndexed[If[#1=={},
{},
If[OddQ[First[#2]],Fold[setMatColToZero,#1,selfConjs],#1] (* for \[CapitalDelta] matrices, set self-conj cols to 0 *)
]&,
A2SRs
]
];
A2SRs=simplifyFactors/@A2SRs;
A2SRs=Map[Cases[Except@{0..}],A2SRs];



system[["Amplitudes"]]=KeyDrop["Multiplet components"]/@system[["Amplitudes"]]; (* removes this key only when using generateSRs, but not generateASRs *)
system=KeyDrop[system,"Unique amp pairs"];
nA2SRs=Table[Length[A2SRs[[i]]],{i,Length[A2SRs]}];

AssociateTo[system,<|"n A2SRs"->nA2SRs,"A2SRs"->A2SRs,"Amp vector"->None,"SR extract"->None|>]
];


(* Returns the total number of amplitudes in the system *)
numAmps[system_,nPairs_:False]:=Module[{amplitudes=system[["Amplitudes"]]},
If[!nPairs,
Length@DeleteDuplicates@Flatten@amplitudes[[All,"Binary index"]],
Length@Flatten@amplitudes[[All,"Coord"]]
]
];


defaultAmpKeys={"Process","QN label","n-tuple","Coord","Binary index","mu","CG","CKM","Multiplet components","Integrated channel ID"};


(* Adds a column to amplitudes *)
SetAttributes[labelAmps,HoldFirst];
Options[labelAmps]={labeling->"Amplitudes"};
labelAmps[system_,colName_String,labels_List,OptionsPattern[]]:=Module[{sysVal=Evaluate[system],amplitudes,pairs,nAmps,labelVals,labeling=OptionValue[labeling],indices,labelIndices},
If[MemberQ[defaultAmpKeys,colName],Message[labelAmps::argval,colName];Return[$Failed]];

amplitudes=sysVal[["Amplitudes"]];
pairs=If[labeling=="Amplitudes",False,True];
nAmps=numAmps[sysVal,pairs];
If[nAmps==Length@Flatten[labels],Null,Message[labelAmps::arglen,labels,nAmps,Length@Flatten[labels]];Return[$Failed]];

labelVals=Which[
labeling=="Amplitude pairs",
labels,
labeling=="Amplitudes",
(indices=amplitudes[[All,"Binary index"]];
labelIndices=Sort[Join[Range[nAmps],Table[If[indices[[i,1]]==indices[[i,2]],2*i-1,Nothing],{i,Length[indices]}]]];
Partition[Table[Flatten[labels][[i]],{i,labelIndices}],2]
),
True,Message[labelAmps::badmode,labeling];Return[$Failed]
];

amplitudes=MapThread[Prepend,{amplitudes,colName->#&/@labelVals}];
system[["Amplitudes"]]=amplitudes;
amplitudes
];

labelAmps::argval="Invalid column name `1`. Use a column name that does not conflict with the built-in amplitude association keys.";
labelAmps::arglen="The labels list `1` has an incorrect number of labels. Expected `2` labels, got `3`. Check that the labeling option is correct.";
labelAmps::badmode="Unknown labeling mode `1`. Use \"Amplitudes\" or \"Amplitude pairs\".";


(* Removes columns from amplitudes *)
SetAttributes[unlabelAmps,HoldFirst];
unlabelAmps[system_,colNames_]:=Module[{sysVal=Evaluate[system],amplitudes},
If[ContainsAny[defaultAmpKeys,Flatten@List@colNames],Message[unlabelAmps::argval,colNames];Return[$Failed]];

amplitudes=sysVal[["Amplitudes"]];
amplitudes=KeyDrop[colNames]/@amplitudes;
system[["Amplitudes"]]=amplitudes;
amplitudes
];

unlabelAmps::argval="Invalid column name(s) `1`. Cannot remove any of the built-in amplitude association keys.";


(* Prints a table of amplitudes *)
Options[printAmps]={showFactors->False};
printAmps[system_,OptionsPattern[]]:=Module[{amplitudes=system[["Amplitudes"]],indices,selfConj,nAmps,showFactors=OptionValue[showFactors],signs},
(* Delete self-conjugate duplicate values from display *)
indices=amplitudes[[All,"Binary index"]];
selfConj=Table[If[indices[[i,1]]==indices[[i,2]],i,Nothing],{i,Length[indices]}];
amplitudes[[selfConj]]=Map[If[ListQ[#],#[[1]],#]&,amplitudes[[selfConj]],{2}];

nAmps=numAmps[system];
If[!showFactors,amplitudes=KeyDrop[#,{"Binary index","mu","CG","Multiplet components"}]&/@amplitudes,Null]; (* show/hide internal factors from display *)
signs=If[system[["p factor"]]==1,{"-","+"},{"+","-"}];

Print["Amplitude table","\n",
"Number of amplitudes: ",nAmps,"\n",
"a/s definitions: \!\(\*SubscriptBox[\(a\), \(i\)]\) = \!\(\*SubscriptBox[\(A\), \(i\)]\) ",signs[[1]]," \!\(\*SubscriptBox[OverscriptBox[\(A\), \(_\)], \(i\)]\), \!\(\*SubscriptBox[\(s\), \(i\)]\) = \!\(\*SubscriptBox[\(A\), \(i\)]\) ",signs[[2]]," \!\(\*SubscriptBox[OverscriptBox[\(A\), \(_\)], \(i\)]\)","\n",
"\[CapitalDelta]/\[CapitalSigma] definitions: \!\(\*SubscriptBox[\(\[CapitalDelta]\), \(i\)]\) = |\!\(\*SubscriptBox[\(A\), \(i\)]\)\!\(\*SuperscriptBox[\(|\), \(2\)]\) - |\!\(\*SubscriptBox[OverscriptBox[\(A\), \(_\)], \(i\)]\)\!\(\*SuperscriptBox[\(|\), \(2\)]\), \!\(\*SubscriptBox[\(\[CapitalSigma]\), \(i\)]\) = |\!\(\*SubscriptBox[\(A\), \(i\)]\)\!\(\*SuperscriptBox[\(|\), \(2\)]\) + |\!\(\*SubscriptBox[OverscriptBox[\(A\), \(_\)], \(i\)]\)\!\(\*SuperscriptBox[\(|\), \(2\)]\)","\n",
TableForm[Prepend[Values/@amplitudes,Keys[amplitudes[[1]]]]]
];
];


(* Returns a list of the orders of breaking *)
listbOrders[b_,nOrders_]:=Module[{bVal=b,bList},
bVal=b/.{
{i_,j_,k_:1}:>Span[
Replace[i,{Null->1,x_Integer:>x+1}],
Replace[j,{Null->All,x_Integer:>x+1}],
k
],
{i_}:>Span[Replace[i,{Null->1,x_Integer:>x+1}],All],
i_Integer:>Span[i+1,i+1],
All:>All
};
bList=Flatten@{(Range[nOrders]-1)[[bVal]]};
bList
];


(* Returns the number of amplitude or amplitude-squared sum rules at each order of breaking *)
Options[numSRs]={b->All};
numSRs[system_,squared_:False,OptionsPattern[]]:=Module[{b=OptionValue[b],SRs,indices,sublist},
SRs=If[squared,
If[KeyExistsQ[system,"A2SRs"],system[["A2SRs"]],(Message[numSRs::missingkey];Return[$Failed])],
system[["ASRs"]]
];
If[b===All,
Table[Length[SRs[[i]]],{i,Length[SRs]}],
(indices=listbOrders[b,Length[SRs]]+1;
sublist=SRs[[indices]];
Table[Length[sublist[[i]]],{i,Length[sublist]}]
)
]
];

numSRs::missingkey="This system does not contain the A2SRs key.";


(* Prints sum rules at each order of breaking *)
SetAttributes[printSRs,HoldFirst];
Options[printSRs]={ampType->None,amp2Type->None,ampFormat->None,showSRs->True,expandSRs->False,CKM->False,b->All,amp2Quad->False};
printSRs[system_,opts:OptionsPattern[]]:=Module[{sysVal=Evaluate[system],ampType=OptionValue[ampType],amp2Type=OptionValue[amp2Type],ampFormat=OptionValue[ampFormat],showSRs=OptionValue[showSRs],expandSRs=OptionValue[expandSRs],CKM=OptionValue[CKM],b=OptionValue[b],amp2Quad=OptionValue[amp2Quad],formatSRMats,ampsToVectors,printWrittenSRs,syms,squared,SRs,p,amplitudes,uniqueAmps,indices,selfConjs,pairedBasis,ampVectors,bList},
(* Function definitions *)
(* Double widths of SRs matrices, add relative signs or p factors, combine self-conj cols *)
formatSRMats[amps_]:=Module[{factorsMats,delSelfConj},
factorsMats=If[squared,
{DiagonalMatrix@Flatten@Table[{1,-1},Length[amps]],IdentityMatrix[2*Length[amps]]}, (* {\[CapitalDelta] mat,\[CapitalSigma] mat} *)
{DiagonalMatrix@Flatten@Table[{1,-p},Length[amps]],DiagonalMatrix@Flatten@Table[{1,p},Length[amps]]} (* {a mat,s mat} *)
];
SRs=Map[Transpose@Flatten[{#,#}&/@Transpose@#,1]&,SRs]; (* duplicates cols of SRs matrix *)
SRs=MapIndexed[If[#1=={},{},If[OddQ[First[#2]],#1 . factorsMats[[1]],#1 . factorsMats[[2]]]]&,SRs]; (* adds factors to SRs matrices *)

delSelfConj[mat_]:=Module[{matVal=mat},
matVal=If[matVal=={},{},
(matVal[[All,Flatten@(2*selfConjs-1)]]+=matVal[[All,Flatten@(2*selfConjs)]]; (* adds together self-conj cols *)
Transpose[Delete[Transpose[matVal],2*selfConjs]]) (* deletes extra self-conj col *)
]
];

SRs=If[Length[selfConjs]>0,Map[delSelfConj[#]&,SRs],SRs]; (* corrects for self-conj amps if necessary *)
SRs
];


(* Return a list of two amplitude vectors (either a,s or two identical A) formatted according to ampFormat. Restore CKM factors and square if necessary, also correct for self-conjugates. *)
ampsToVectors[amps_]:=Module[{ampsToVector,vec1,vecList},
If[ampFormat=="Process"&&!KeyExistsQ[amps[[1]],"Process"],Message[printSRs::invalidformat];Return[$Failed],Null];

(* Format amplitude vector for printing *)
ampsToVector[ampSym_Symbol]:=Module[{vector,rule},
(* Turn inputted symbol(s) into indexed variable(s) indexed by the values in the selected column of the amplitude table *)
vector=Map[ampSym[#]&,
If[pairedBasis,
(Switch[ampFormat, (* a/s amps *)
"Process",(Message[printSRs::invalidformat];Return[$Failed]),
"QN label",amps[[All,"QN label",1]], (* a/s-type amps with QNs *)
"n-tuple",amps[[All,"n-tuple",1]], (* a/s-type amps with n-tuples *)
"Coord",amps[[All,"Coord"]], (* a/s-type amps with coords *)
"Binary index",amps[[All,"Binary index",1]], (* a/s-type amps with numbered subscripts *)
_String/;KeyExistsQ[amps[[1]],ampFormat],amps[[All,ampFormat]], (* custom amplitude format *)
_,(Message[printSRs::invalidformat];Return[$Failed])
]
),
(Switch[ampFormat, (* A amps *)
"Process",Flatten@amps[[All,"Process"]], (* A amps with physical processes *)
"QN label",Flatten@amps[[All,"QN label"]], (* A amps with QNs *)
"n-tuple",Flatten@amps[[All,"n-tuple"]], (* A amps with n-tuples *)
"Coord",(Message[printSRs::invalidformat];Return[$Failed]),
"Binary index",Flatten@amps[[All,"Binary index"]], (* A amps with numbered subscripts *)
_String/;KeyExistsQ[amps[[1]],ampFormat],Flatten@amps[[All,ampFormat]], (* custom amplitude format *)
_,(Message[printSRs::invalidformat];Return[$Failed])
]
)
]
];


(* Format vector of indexed variables for printing *)
rule=If[ampFormat=="Process"||ampFormat=="QN label",
expr_Symbol[i_]/;expr=!=List:>StringJoin[ToString[expr],"(",i,")"],
expr_Symbol[i_]/;expr=!=List:>Subscript[expr,i]
];
vector=vector/.rule;


(* Restore CKM factors and square vector if necessary *)
If[!pairedBasis&&CKM,
If[amp2Quad&&squared,
vector=vector/(Abs[#]^2&/@Flatten@amps[[All,"CKM"]]), (* for squared amp2Quad true cases, square CKM before dividing *)
vector=vector/Flatten@amps[[All,"CKM"]]
]
]; (* divide by CKM. notes: CKM factors can only be restored in the non-paired amp basis, amp2Quad must be paired with squared *)
If[!pairedBasis&&squared&&(!amp2Quad),vector=Abs[#]^2&/@vector]; (* for squared amp2Quad false cases, square entire vector *)

vector
];


(* Form amplitude vector(s): either one for a/\[CapitalDelta] and one for s/\[CapitalSigma], or two identical A/|A|^2/\[CapitalGamma] vectors *)
vec1=ampsToVector[syms[[1]]];
vecList=If[pairedBasis,{vec1,ampsToVector[syms[[2]]]},{vec1,vec1}];

(* Correct for self-conj amps *)
vecList=If[Length[selfConjs]>0,
(If[!pairedBasis,
Map[Delete[#,2*selfConjs]&,vecList], (* for A/|A|^2/\[CapitalGamma], delete conj of self-conj amp *)
Delete[vecList,Transpose@{ConstantArray[If[squared,1,If[(p==1),1,2]],Length[selfConjs]],Flatten@selfConjs}] (* for \[CapitalDelta]/\[CapitalSigma] drop identically 0 \[CapitalDelta]. for a/s drop a if p is 1, otherwise drop s *)
]
),
vecList
]; 

vecList
];


(* Print SRs: combine amp vecs with SR matrices and print results at each order *)
printWrittenSRs[]:=Module[{numSRsList,matForm,writtenSRs},
numSRsList=numSRs[sysVal,squared,Sequence@@FilterRules[{opts},Options[numSRs]]];
matForm:=If[expandSRs,MatrixForm[#]&,MatrixForm[#[[2;;]],TableHeadings->{None,#[[1]]}]&];
writtenSRs=If[expandSRs,
MapIndexed[If[#1=={},{},If[OddQ[First[#2]],#1 . ampVectors[[1]],#1 . ampVectors[[2]]]]&,SRs],
MapIndexed[If[#1=={},{},If[OddQ[First[#2]],Prepend[#1,ampVectors[[1]]],Prepend[#1,ampVectors[[2]]]]]&,SRs]
]; (* if expandSRs, take product between SR mat and amp vec, otherwise turn amp vec into header row of SR mat *)

If[squared,Print["Amplitude-squared sum rules"],Print["Amplitude sum rules"]];
MapIndexed[
Print["b = ",bList[[#2[[1]]]],"\n",
"Number of SRs: ",numSRsList[[#2[[1]]]],"\n",
If[#1=={},"No sum rules found at this order.",matForm[#1]//TraditionalForm]
]&,
writtenSRs[[bList+1]]
];
];



(* Function calls *)
(* Select the set of SRs to be printed: ASRs (squared = False) or A2SRs (squared = True) *)
If[(ampType==None)&&(amp2Type==None),(Message[printSRs::missingtype];Return[$Failed])]; (* error if no amp type is specified *)
{syms,squared}=If[(amp2Type=!=None),{amp2Type,True},{ampType,False}]; (* only one opt should be specified, but if both are specified, keep amp2Type by default. squared is true if working with |A|^2, \[CapitalGamma], or \[CapitalDelta]/\[CapitalSigma] *)
SRs=If[squared,
If[KeyExistsQ[sysVal,"A2SRs"],sysVal[["A2SRs"]],(Message[printSRs::missingkey];Return[$Failed])],
sysVal[["ASRs"]]
]; (* set SRs list to either ASRs or A2SRs *)


(* Extract p factor, amplitude table (reduced to unique integrated rows if necessary), and indices of self-conjugate amp pairs *)
p=sysVal[["p factor"]];
amplitudes=sysVal[["Amplitudes"]];
uniqueAmps=If[squared&&(KeyExistsQ[amplitudes[[1]],"Integrated channel ID"]),Flatten[First/@Values[PositionIndex[Sort/@amplitudes[[All,"Integrated channel ID"]]]]]]; (* unique integrated amp pair rows *)
If[squared&&(KeyExistsQ[amplitudes[[1]],"Integrated channel ID"]),amplitudes=amplitudes[[uniqueAmps]]];(* if printing A2SRs for sys with integrated observables, reduce amps assoc to unique amps. note amp table printing is unaffected because it's handled by printAmps *)
indices=If[squared&&(KeyExistsQ[amplitudes[[1]],"Integrated channel ID"]),
amplitudes[[All,"Integrated channel ID"]],
amplitudes[[All,"Binary index"]]
];
selfConjs=Table[If[indices[[i,1]]==indices[[i,2]],{i},Nothing],{i,Length[indices]}]; (* Some notes: formatSRMats combines self-conj cols in SR mats written in a non-paired amplitude basis, the code below (beginning with If[pairedBasis...]) directly drops identically 0 cols for SR mats in a paired basis, and ampsToVectors deletes redundant or identically 0 amps from the amp vector(s). Includes fake self-conjs in integrated observables case. Indices are formatted like {{1},{2},...}. *)


(* Indicate whether amplitudes are written in a paired basis, set defaults for ampFormat *)
pairedBasis=Switch[Length[syms],
1,False, (* A, |A(|^2), \[CapitalGamma] *)
2,True, (* a/s, \[CapitalDelta]/\[CapitalSigma] *)
_,(Message[printSRs::invalidformat];Return[$Failed])
]; (* true if amplitudes are in a paired basis *)
If[ampFormat==None,
If[!pairedBasis&&(KeyExistsQ[amplitudes[[1]],"Process"]),ampFormat="Process",ampFormat="n-tuple"],
Null
]; (* if no ampFormat was specified, set to n-tuples by default unless it's a physical system with A/|A|^2/\[CapitalGamma] amplitudes *)


(* Format SR matrices for printing: if using a non-paired amplitude basis, double widths of SRs matrices, add relative signs or p factors, and combine self-conj cols; otherwise, drop identically 0 self-conj cols *)
If[!pairedBasis,
formatSRMats[amplitudes], (* non-paired amp basis option: double widths etc *)
If[Length[selfConjs]>0, (* paired amp basis option: drop identically 0 cols *)
SRs=MapIndexed[If[#1=={},
{},
If[If[squared,True,p==1]==OddQ[First[#2]],Transpose[Delete[Transpose[#1],selfConjs]],#1] (* for \[CapitalDelta]/\[CapitalSigma] drop for \[CapitalDelta] (odd mathematica indices). for a/s drop for a (odd) if p is 1, otherwise drop for s (even) *)
]&,
SRs
]
]
];
SRs=simplifyFactors/@SRs;


(* Format amplitude vector(s) for printing: return either formatted {a/\[CapitalDelta] vector, s/\[CapitalSigma] vector} or two identical A/|A|^2/\[CapitalGamma] vectors *)
ampVectors=ampsToVectors[amplitudes];

(* Extract the orders to print *)
bList=listbOrders[b,Length[SRs]];

(* Print SRs *)
If[showSRs,printWrittenSRs[]];

(* Extract formatted amplitude vector(s) and SRs *)
system[["Amp vector"]]=If[!pairedBasis,ampVectors[[1]],ampVectors];
SRs=If[Length[bList]==1,SRs[[bList+1]][[1]],SRs[[bList+1]]];
system[["SR extract"]]=SRs;

SRs
];

printSRs::missingtype="Missing amplitude type. Please specify an amplitude type for either ampType or amp2Type.";
printSRs::invalidformat="Invalid or missing amplitude format.";
printSRs::missingkey="This system does not contain the A2SRs key.";


SetAttributes[printSystem,HoldFirst];
Options[printSystem]=Join[{showReps->True,showAmps->True,showASRs->True,showA2SRs->True},Options[printAmps],Options[printSRs]];
printSystem[system_,opts:OptionsPattern[]]:=Module[{sysVal=Evaluate[system],showReps=OptionValue[showReps],showAmps=OptionValue[showAmps],showASRs=OptionValue[showASRs],showA2SRs=OptionValue[showA2SRs],printLine,irreps},
printLine[]:=Print["-------------------------"];
irreps=sysVal[["Irreps"]];

If[showReps,
(Print["System: ",Sort@Flatten@irreps];
printLine[];
Print["Number of would-be doublets: ",sysVal[["n doublets"]],"\n",
"In: ",irreps[[1]],"\n",
"H: ",irreps[[2]],"\n",
"Out: ",irreps[[3]]
];
),
Null
];

If[showAmps,
If[showReps,printLine[]];
printAmps[sysVal,Sequence@@FilterRules[{opts},Options[printAmps]]];
];

If[showASRs,
If[showReps||showAmps,printLine[]];
printSRs[sysVal,Sequence@@FilterRules[FilterRules[{opts},Except[amp2Type]],Options[printSRs]],showSRs->showASRs,amp2Type->None];
];

If[showA2SRs,
If[showReps||showAmps||showASRs,printLine[]];
printSRs[sysVal,Sequence@@FilterRules[FilterRules[{opts},Except[ampType]],Options[printSRs]],showSRs->showA2SRs,ampType->None];
];

system=sysVal;
sysVal
];


End[]


EndPackage[]
