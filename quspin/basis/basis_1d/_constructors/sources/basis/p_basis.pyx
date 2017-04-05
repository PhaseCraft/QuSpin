





def make_m_p_basis(int L, int Nup, int pblock, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_UINT32_t ,ndim=1]  basis):
	cdef unsigned int s,Ns
	cdef NP_INT8_t rp
	cdef char stp

	cdef int j

	s = 0
	for j in range(Nup):
		s += ( 1ull << j )

	stp = 0
	Ns = 0

	while True:
		rp = CheckState_P(pblock,s,L)
		if rp > 0:
			basis[Ns] = s
			N[Ns] = rp
			Ns += 1

		stp = 1 & ( s >> (L-1) )
		for i in range(1,Nup):
			stp &= 1 & ( s >> (L-i-1) )

		if stp or (s == 0):
			break


		s = next_state(s)

	return Ns








def make_p_basis(int L, int pblock,	_np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_UINT32_t ,ndim=1]  basis):
	cdef unsigned long long s
	cdef int Ns
	cdef NP_INT8_t rp

	Ns = 0

	for s in range(1llu << L):
		rp = CheckState_P(pblock,s,L)
		if rp > 0:
			basis[Ns] = s
			N[Ns] = rp
			Ns += 1

	return Ns

