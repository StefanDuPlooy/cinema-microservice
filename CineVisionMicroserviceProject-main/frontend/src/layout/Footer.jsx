import React from 'react'

export default function Footer() {
  return (
    <div>

        <footer className="py-5" style={{background: "linear-gradient(to right, #121212, #1E1E1E, #121212)", borderTop: "1px solid rgba(255,255,255,0.05)"}}>
            <div className="container px-5">
              <div className="row justify-content-center mb-4">
                <div className="col-auto">
                  <h2 className="text-center mb-4" style={{color: "var(--bs-primary)", fontWeight: "700"}}>Secure Cinema</h2>
                </div>
              </div>
              <div className='row justify-content-evenly align-items-center'>
                <div className='col-md-4 mb-4 mb-md-0'>
                  <h5 className="text-white mb-3 border-bottom pb-2" style={{borderColor: "var(--bs-primary) !important"}}>Movies</h5>
                  <p className='m-2 text-white opacity-75'>Now Showing</p>
                  <p className='m-2 text-white opacity-75'>Coming Soon</p>
                  <p className='m-2 text-white opacity-75'>Cinemas</p>
                </div>
                <div className='col-md-4'>
                  <h5 className="text-white mb-3 border-bottom pb-2" style={{borderColor: "var(--bs-primary) !important"}}>Information</h5>
                  <p className='m-2 text-white opacity-75'>E-Ticket</p>
                  <p className='m-2 text-white opacity-75'>Refund Procedures</p>
                  <p className='m-2 text-white opacity-75'>Sales Agreement</p>
                </div>
              </div>
              <div className="row mt-5">
                <div className="col">
                  <div className="border-top pt-4" style={{borderColor: "rgba(255,255,255,0.1) !important"}}>
                    <p className="text-center text-white small mb-0">
                      <strong>Copyright &copy; Secure Cinema 2025</strong>
                    </p>
                  </div>
                </div>
              </div>
            </div>
        </footer>

    </div>
  )
}
