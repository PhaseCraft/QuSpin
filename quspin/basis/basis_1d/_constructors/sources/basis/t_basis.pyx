


def make_t_basis(int L,int kblock,int a, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_UINT32_t ,ndim=1]  basis):
	cdef unsigned long long s
	cdef int Ns
	cdef NP_INT8_t r

	Ns = 0

	for s in range(1ull << L):
		r=CheckState_T(kblock,L,s,a)

		if r>0:
			N[Ns] = r				
			basis[Ns] = s
			Ns += 1		

	return Ns








def make_m_t_basis(int L, int Nup, int kblock, int a, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_UINT32_t ,ndim=1]  basis):
	cdef unsigned int Ns,s
	cdef NP_INT8_t r
	cdef int i
	cdef char stp

	cdef int j

	s = 0
	for j in range(Nup):
		s += ( 1ull << j )

	stp = 0
	Ns = 0

	while True:
		r=CheckState_T(kblock,L,s,a)

		if r > 0:
			N[Ns] = r				
			basis[Ns] = s
			Ns += 1		

		stp = 1 & ( s >> (L-1) ) 
		for i in range(1,Nup):
			stp &= 1 & ( s >> (L-i-1) )

		if stp or (s == 0):
			break
		
		s = next_state(s)



	return Ns
