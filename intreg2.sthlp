{smcl}
{* *! version 1.0  2jun2016}{...}
{viewerjumpto "Syntax" "examplehelpfile##syntax"}{...}
{viewerjumpto "Description" "examplehelpfile##description"}{...}
{viewerjumpto "Options" "examplehelpfile##options"}{...}
{viewerjumpto "Remarks" "examplehelpfile##remarks"}{...}
{viewerjumpto "Examples" "examplehelpfile##examples"}{...}
{viewerjumpto "References" "references##references"}{...}

{title:Title}

{phang}
{bf:intreg2} {hline 2} Generalized Interval Regression


{marker syntax}{...}
{title:Syntax}

{p 8 20 2}
{cmdab:intreg2}
{it:{help depvar:depvar1}}
{it:{help depvar:depvar2}}
[{indepvars}]
[{it:if}]
[{it:in}]
[{cmd:,} {it:options}]

{pstd}
{it:depvar1} and {it:depvar2} should have the following form:

             Type of data {space 16} {it:depvar1}  {it:depvar2}
             {hline 46}
             point data{space 10}{it:a} = [{it:a},{it:a}]{space 4}{it:a}{space 8 }{it:a} 
             interval data{space 11}[{it:a},{it:b}]{space 4}{it:a}{space 8}{it:b }
             left-censored data{space 3}(-inf,{it:b}]{space 4}{cmd:.}{space 8}{it:b}
             right-censored data{space 3}[{it:a},inf){space 4}{it:a}{space 8}{cmd:.} 
             {hline 46}




{synoptset 24 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt dist:ribution}(dist_type)} dist_type may be gb2, gg, lnormal, sgt, sged, or
normal; Default is normal. {p_end}
{synopt:{opth const:raints(numlist)}} specified linear constraints by number to be applied. Can use this option along with {opt dist:ribution} to allow for any distribution in the SGT or GB2 family trees.{p_end}
{syntab: Model}
{synopt:{cmdab: sigma(}{varlist}{cmd:)}} allow sigma to vary as a function of independent variables; can use with dist_type normal, lnormal, sgt, or sged. {p_end}
{synopt:{cmdab: lambda(}{varlist}{cmd:)}} allow lambda to vary as a function of independent variables; can use with dist_type sgt or sged. {p_end}
{synopt:{cmdab: p(}{varlist}{cmd:)}} allow p to vary as a function of independent variables; can use with dist_type gb2, gg, sgt, or sged. {p_end}
{synopt:{cmdab: q(}{varlist}{cmd:)}} allow q to vary as a function of independent variables; can use with dist_type gb2 or sgt. {p_end}
{synopt:{cmdab: b(}{varlist}{cmd:)}} allow b to vary as a function of independent variables; can use with dist_type gb2. {p_end}
{synopt:{cmdab: beta(}{varlist}{cmd:)}} allow beta to vary as a function of independent variables; can use with dist_type gg. {p_end}

{syntab: SE/Robust}

{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},{opt r:obust}, {opt cl:uster} {it:clustvar}, {opt opg}, {opt boot:strap}, or {opt jack:knife}. {p_end}
{synopt:{opt robust}} use robust standard errors. {p_end}
{synopt: {cmd: cluster(}{varlist}{cmd:)}} cluster standard errors with respect to sampling
unit {varlist}. {p_end}


{syntab: Estimation}
{synopt:{opth init:ial(numlist)}} initial values for constant only parameters.{p_end}
{synopt:{it:{help ml##noninteractive_maxopts:maximize_options}}}control the
maximization process{p_end}

{syntab: Display}
{synopt: {opt showc:onstonly}} Show the estimated constant only model. {p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:intreg2} fits a model of {depvar} on {indepvars} using maximum likelihood
where the dependent variable can be point data, interval data, right-censored data,
or left-censored data. This is a generalization of the built in STATA command
{cmd: intreg} and will yield identical estimates if the normal distribution option is used.
Unlike {cmd: intreg}, {cmd: intreg2} allows the underlying variable of interest to
be distributed according to a more general distribution including all distributions
in the Skewed Generalized T family and Generalized Beta of the Second Kind tree.

 



{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt dist:ribution}(dist_type) specifies the type of distribution used in the interval regressions.
{cmd: intreg2} will use a log-likelihood function composed of the pdf and cdf of this distribution
(pdf for point data and cdf for intervals and censored observations). dist_type may be gb2, gg, lnormal, sgt, sged, or
normal; Default is normal. 

{phang}
{cmd:constraints(}{it:{help numlist)}} specified linear constraints by number to be applied. 
Can use this option along with {opt dist:ribution} to allow for any distribution in the SGT or GB2 family trees.
Constraints are defined using the {cmd:constraint}
command; see {manhelp constraint R}.

{dlgtab: Model}

{phang}
The {indepvars} specified will allow the location parameter (mu or a) to vary
as a function of the independent variables. The other parameters in the distribution
can also be a function of explanatory variables by using the commands below.
If the user specifies a parameter that is not part of dist_type then {cmd: intreg2}
will throw an error; e.g. specifying independent variables for q when using the
Generalized Gamma distribution.

{phang}
{cmd:sigma(}{it:{help varlist)}} allows sigma to be a function of {varlist}  and can 
model heteroskedasticity.

{phang}
{cmd:lambda(}{it:{help varlist)}} allows lambda to be a function of {varlist}  
and can model skewness.

{phang}
{cmd:p(}{it:{help varlist)}} allows p to be a function of {varlist}. A shape parameter
that impacts the tail thickness and peakedness of the distribution.

{phang}
{cmd:q(}{it:{help varlist)}} allows q to be a function of {varlist}. A shape parameter
that impacts the tail thickness and peakedness of the distribution.

{phang}
TODO: Transform GB2 and GG so that these distributions will have mu and sigma
parameters instead of a and b parameters.

{dlgtab: Standard Errors}

{phang}
{opt vce(vcetype)} specifies the type of standard error reported, which includes
        types that are robust to some kinds of misspecification (robust), that
        allow for intragroup correlation (cluster clustvar), and that are
        derived from asymptotic theory (oim, opg); see {manhelp vce_option R}.

{phang}
{opt robust} use robust standard errors.

{phang}
{cmd: cluster(}{varlist}{cmd:)} cluster standard errors with respect to sampling
unit {varlist}.

{dlgtab: Estimation}
		
{phang}
{cmd: initial(}{it: {help numlist}}{cmd:)} 
list of numbers that specifies the initial values of the parameters in the constant
only model. This must be equal to the number of distributional parameters; 
i.e. two for the normal and log-normal, three for the Generalized Gamma, four for
the GB2 and the SGED, and five for the SGT. 

{phang}{marker noninteractive_maxopts}
{it:maximize_options}:
{opt dif:ficult},
{opt tech:nique(algorithm_spec)},
{opt iter:ate(#)},
[{cmdab:no:}]{opt lo:g},
{opt tr:ace},
{opt grad:ient},
{opt showstep},
{opt hess:ian},
{opt showtol:erance},
{opt tol:erance(#)},
{opt ltol:erance(#)},
{opt nrtol:erance(#)}; see {manhelp maximize R}.

{dlgtab: Display}

{phang}
{opt showc:onstonly} {cmd:: intreg2} will always estimate the constant only model
first prior to estimating the model with {indepvars}, but this output is suppressed.
 Use this option to see the estimate of the constant only model.

{marker remarks}{...}
{title:Remarks}

{pstd}
If the optimization is not working, try using the difficult option. You can also use the option {cmd: technique(bfgs)}, or the other two {cmd: technique} options,
 which are often more robust than the default {cmd: technique(nr)}.


{marker examples}{...}
{title:Examples}

{pstd}
We have a dataset containing wages, truncated and in categories.  Some of
the observations on wages are

        wage1    wage2
{p 8 27 2}20{space 7}25{space 6} meaning  20000 <= wages <= 25000{p_end}
{p 8 27 2}50{space 8}.{space 6} meaning 50000 <= wages

{pstd}Setup{p_end}
{phang2}{cmd:. webuse intregxmpl}{p_end}

{pstd}Interval regression with normal distribution{p_end}
{phang2}{cmd:. intreg2 wage1 wage2 age c.age#c.age nev_mar rural school tenure}

{pstd}Interval regression with gb2 distribution (use difficult option) {p_end}
{phang2}{cmd:. intreg2 wage1 wage2 age c.age#c.age nev_mar rural school, distribution(gb2) difficult}


{pstd}Interval regression with sgt distribution allowing sigma to vary as a function of independent variables{p_end}
{phang2}{cmd:. intreg2 wage1 wage2 age c.age#c.age nev_mar rural school tenure, distribution(sgt) sigma(age)}

{pstd}Interval regression using the t distribution (TODO: This isn't working currently) {p_end}
{phang2}{cmd:. constraint define 1 [lambda]_cons=0}

{phang2}{cmd:. constraint define 2 [p]_cons=2 }

{phang2}{cmd:. intreg2 wage1 wage2 age c.age#c.age nev_mar rural school tenure, distribution(sgt) constraints( 1 2)}

{marker references}{...}
{title:References}

{phang}
James B., McDonald, Olga Stoddard, and Daniel Walton. 2016.
{it:On using interval response data in experimental economics},
working paper.


