




def make_m_t_p_basis(int L, int Nup, int pblock, int kblock, int a, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis):
	cdef unsigned int Ns,s
	cdef NP_INT8_t r_temp,r,mp
	cdef int sigma,sigma_i,sigma_f,v
	cdef _np.ndarray[NP_INT8_t,ndim=1] R = _np.zeros(2,dtype=NP_INT8)
	cdef char stp
	
	cdef double k = (2.0*_np.pi*kblock*a)/L

	if ((2*kblock*a) % L) == 0: #picks up k = 0, pi modes
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
		CheckState_T_P(kblock,L,s,a,R)
		r = R[0]
		mp = R[1]
		if r > 0:
			if mp != -1:
				for sigma in range(sigma_i,sigma_f+1,2):
					r_temp = r
					if 1 + sigma*pblock*cos(mp*k) == 0:
						r_temp = -1
					if (sigma == -1) and (1 - sigma*pblock*cos(mp*k) != 0):
						r_temp = -1
	
					if r_temp > 0:
						m[Ns] = mp
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














def make_t_p_basis(int L, int pblock,int kblock,int a, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t, ndim=1] basis):
	cdef unsigned long long s
	cdef NP_INT8_t r_temp,r,mp
	cdef int Ns,sigma,sigma_i,sigma_f
	cdef _np.ndarray[NP_INT8_t,ndim=1] R = _np.zeros(2,dtype=NP_INT8)
	cdef double k = (2.0*_np.pi*kblock*a)/L


	if ((2*kblock*a) % L) == 0: #picks up k = 0, pi modes
		sigma_i = 1
		sigma_f = 1
	else:
		sigma_i = -1
		sigma_f = 1

	Ns = 0
	for s in range(1ull << L):
		CheckState_T_P(kblock,L,s,a,R)
		r = R[0]
		mp = R[1]
		if r > 0:
			if mp != -1:
				for sigma in range(sigma_i,sigma_f+1,2):
					r_temp = r
					if 1 + sigma*pblock*cos(mp*k) == 0:
						r_temp = -1
					if (sigma == -1) and (1 - sigma*pblock*cos(mp*k) != 0):
						r_temp = -1
	
					if r_temp > 0:
						m[Ns] = mp
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




