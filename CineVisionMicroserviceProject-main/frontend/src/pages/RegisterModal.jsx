import { Form, Formik } from 'formik';
import React from 'react'
import { useState } from 'react';
import { UserService } from '../services/userService'
import KaanKaplanTextInput from '../utils/customFormItems/KaanKaplanTextInput';
import { ToastContainer, toast } from 'react-toastify';

export default function RegisterModal() {

    const userService = new UserService();

    const registerCustomer = (values) => {

        if (values.password === values.passwordAgain) {

            let customer = {
                customerName: values.customerName,
                email: values.email,
                phone: values.phone,
                password: values.password
            };

            userService.addCustomer(customer).then(result => {
                if(result.status == 200) {
                    document.querySelector("#loginModalLink").click();
                    toast("Your account has been successfully created! Please login.", {
                        theme:"colored",
                        position:"top-center"
                    })
                }
            })
        } else {
            toast.error("Your password values don't match.", {
                theme: "colored",
                position: "top-center"
            });
        }
    }

  return (
    <div>
        <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                <div class="modal-header login-modal-header">
                    <h5 class="modal-title" id="registerModalLabel">Register</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <Formik 
                    initialValues={{}}
                    onSubmit={(values) => {
                        registerCustomer(values);
                    }}>
                    <Form>
                        <div class="modal-body">
                            <div class="form-floating mb-3">
                                <KaanKaplanTextInput type="text" name="customerName" className="form-control" id="customerName" placeholder='Full Name' required/>
                                <label for="customerName">Full Name</label>
                            </div>
                            <div className="form-floating mb-3">
                                <KaanKaplanTextInput type="email" name="email" className="form-control" id="email" placeholder='Email' required />
                                <label for="email">Email</label>
                            </div>
                            <div className="form-floating mb-3">
                                <KaanKaplanTextInput type="tel" name="phone" className="form-control" id="phone" placeholder='Phone' pattern="^0[0-9]{2} [0-9]{3} [0-9]{4}$" required />
                                <label for="phone">Phone - 0XX XXX XXXX</label>
                            </div>
                            <div className="form-floating mb-3">
                                <KaanKaplanTextInput type="password" name="password" className="form-control" id="password" placeholder='Password' required/>
                                <label for="password">Password</label>
                            </div>
                            <div className="form-floating mb-3">
                                <KaanKaplanTextInput type="password" name="passwordAgain" className="form-control" id="passwordAgain" placeholder='Confirm Password' required/>
                                <label for="passwordAgain">Confirm Password</label>
                            </div>
                            <p className='ps-2 text-start' style={{color: "#000000"}}>
                                Already a member?
                                <a href='!#' id="loginModalLink" style={{color:"var(--bs-secondary)", fontWeight: "600", marginLeft: "5px"}}
                                data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
                            </p>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary login-modal-btn">Register</button>
                        </div>
                    </Form>
                </Formik>
                </div>
            </div>
        </div>
        <ToastContainer />
    </div>
  )
}
