/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Timestamp;

/**
 *
 * @author MSI PC
 */
public class UserVerificationDTO {
    private String email;
    private String code;
    private Timestamp generatedTime;
    private Timestamp expiredTime;
    private int attemptCount;

    public UserVerificationDTO() {
    }

    public UserVerificationDTO(String email, String code, Timestamp generatedTime, Timestamp expiredTime, int attemptCount) {
        this.email = email;
        this.code = code;
        this.generatedTime = generatedTime;
        this.expiredTime = expiredTime;
        this.attemptCount = attemptCount;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Timestamp getGeneratedTime() {
        return generatedTime;
    }

    public void setGeneratedTime(Timestamp generatedTime) {
        this.generatedTime = generatedTime;
    }

    public Timestamp getExpiredTime() {
        return expiredTime;
    }

    public void setExpiredTime(Timestamp expiredTime) {
        this.expiredTime = expiredTime;
    }

    public int getAttemptCount() {
        return attemptCount;
    }

    public void setAttemptCount(int attemptCount) {
        this.attemptCount = attemptCount;
    }
    
}
