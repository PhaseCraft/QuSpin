
def make_m_p_z_basis(int L, int Nup, int pblock, int zblock, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_UINT32_t,ndim=1] basis):
	cdef unsigned int s,Ns
	cdef NP_INT8_t rpz
	cdef int i
	cdef char stp

	cdef int j

	s = 0
	for j in range(Nup):
		s += ( 1ull << j )

	stp = 0
	Ns = 0
	while True:
		rpz = CheckState_P_Z(pblock,zblock,s,L)
		if rpz > 0:
			basis[Ns] = s
			N[Ns] = rpz
			Ns += 1

		stp = 1 & ( s >> (L-1) ) 
		for i in range(1,Nup):
			stp &= 1 & ( s >> (L-i-1) )

		if stp or (s == 0):
			break


		s = next_state(s)


	return Ns






def make_p_z_basis(int L, int pblock, int zblock, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_UINT32_t,ndim=1] basis):
	cdef unsigned int Ns
	cdef unsigned long long s
	cdef NP_INT8_t rpz

	Ns = 0

	for s in range(1llu << L):
		rpz = CheckState_P_Z(pblock,zblock,s,L)
		if rpz > 0:
			basis[Ns] = s
			N[Ns] = rpz
			Ns += 1

	return Ns




