def make_m_zA_zB_basis(int L, int Nup, _np.ndarray[NP_UINT32_t,ndim=1] basis):
	cdef unsigned int s,Ns
	cdef NP_INT8_t r
	cdef char stp
	cdef int j

	s = 0
	for j in range(Nup):
		s += ( 1ull << j )

	if (Nup == L) or (Nup == 0):
		return 0

	stp = 0
	Ns = 0
	while True:
		r = CheckState_ZA_ZB(s,L)
		if r > 0:
			basis[Ns] = s
			Ns += 1

		stp = 1 & ( s >> (L-1) ) 
		for i in range(1,Nup):
			stp &= 1 & ( s >> (L-i-1) )

		if stp or (s == 0):
			break

		s = next_state(s)


	return Ns



def make_zA_zB_basis(int L, _np.ndarray[NP_UINT32_t,ndim=1] basis):
	cdef unsigned long long s
	cdef int Ns
	cdef NP_INT8_t r

	Ns = 0

	for s in range(1ull << L):
		r = CheckState_ZA_ZB(s,L)
		if r > 0:
			basis[Ns] = s
			Ns += 1

	return Ns
