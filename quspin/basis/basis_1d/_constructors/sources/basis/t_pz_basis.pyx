





def make_m_t_pz_basis(int L, int Nup, int pzblock, int kblock, int a, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis):
	cdef double k 
	
	cdef unsigned int Ns,s
	cdef int sigma,sigma_i,sigma_f
	cdef NP_INT8_t r_temp,r,mpz
	cdef _np.ndarray[NP_INT8_t,ndim=1] R = _np.zeros(2,dtype=NP_INT8)
	cdef char stp
	
	k = 2.0*_np.pi*kblock*a/L

	if (2*kblock*a) % L == 0: #picks up k = 0, pi modes
		sigma_i = 1
		sigma_f = 1
	else:
		sigma_i = -1
		sigma_f = 1


	cdef int j

	s = 0
	for j in range(Nup):
		s += ( 1ull << j )

	stp = 0
	Ns = 0
	while True:
		CheckState_T_PZ(kblock,L,s,a,R)
		r = R[0]
		mpz = R[1]
		if r > 0:
			if mpz != -1:
				for sigma in range(sigma_i,sigma_f+1,2):
					r_temp = r
					if 1 + sigma*pzblock*cos(mpz*k) == 0:
						r_temp = -1
					if (sigma == -1) and (1 - sigma*pzblock*cos(mpz*k) != 0):
						r_temp = -1
	
					if r_temp > 0:
						m[Ns] = mpz
						N[Ns] = (sigma*r)				
						basis[Ns] = s
						Ns += 1
			else:
				for sigma in range(sigma_i,sigma_f+1,2):
					m[Ns] = -1
					N[Ns] = (sigma*r)				
					basis[Ns] = s
					Ns += 1

		stp = 1 & ( s >> (L-1) ) 
		for i in range(1,Nup):
			stp &= 1 & ( s >> (L-i-1) )

		if stp or (s == 0):
			break

		s = next_state(s)



	return Ns













def make_t_pz_basis(int L, int pzblock,int kblock,int a, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis):
	cdef double k = 2.0*_np.pi*kblock*a/L
	cdef unsigned long long s
	cdef int Ns,sigma,sigma_i,sigma_f
	cdef NP_INT8_t r_temp,r,mpz
	cdef _np.ndarray[NP_INT8_t,ndim=1] R = _np.zeros(2,dtype=NP_INT8)
	

	if ((2*kblock*a) % L) == 0: #picks up k = 0, pi modes
		sigma_i = 1
		sigma_f = 1
	else:
		sigma_i = -1
		sigma_f = 1

	Ns = 0
	for s in range(1ull << L):
		CheckState_T_PZ(kblock,L,s,a,R)
		r = R[0]
		mpz = R[1]
		if r > 0:
			if mpz != -1:
				for sigma in range(sigma_i,sigma_f+1,2):
					r_temp = r
					if 1 + sigma*pzblock*cos(mpz*k) == 0:
						r_temp = -1
					if (sigma == -1) and (1 - sigma*pzblock*cos(mpz*k) != 0):
						r_temp = -1
	
					if r_temp > 0:
						m[Ns] = mpz
						N[Ns] = (sigma*r)				
						basis[Ns] = s
						Ns += 1
			else:
				for sigma in range(sigma_i,sigma_f+1,2):
					m[Ns] = -1
					N[Ns] = (sigma*r)				
					basis[Ns] = s
					Ns += 1


	return Ns












