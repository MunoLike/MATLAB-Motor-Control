clear
syms R L Ke Om(t) I(t) s V J D Kt

eq1=R*I(t)+L*diff(I(t), t)+Ke*Om(t)==V
eq2=J*diff(Om(t),t)+D*Om(t)==Kt*I(t)

eqns=[eq1,eq2]

eqns_lt = laplace(eqns, t, s)

syms Om_LT I_LT
eqns_lt=subs(eqns_lt, [laplace(I(t), t, s), laplace(Om(t), t, s), Om(0), I(0)], [I_LT, Om_LT, 0, 0])

vars = [I_LT, Om_LT]
[I_lt, Om_lt] = solve(eqns_lt, vars)

I_sol=ilaplace(I_lt, s, t)
Om_sol = ilaplace(Om_lt, s, t)

eq1=subs(eq1, [I(t), Om(t)], [I_sol, Om_sol])
isolate(eq1, V)


clear
syms R L Ke Om I(t) s V J D Kt

eq3=(V-Ke*Om)/(R+L*s)==(J*s+D)*Om/Kt
Om=simplify(isolate(eq3, Om))