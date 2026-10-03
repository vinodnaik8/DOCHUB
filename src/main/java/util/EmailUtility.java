package util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtility {

    // Your Gmail Address
    private static final String EMAIL = "projectmailid08@gmail.com";

    // Gmail App Password (NO SPACES)
    private static final String PASSWORD = "dzyhzqlxvhjvlopz";

    public static boolean sendOTP(String toEmail, String otp) {

        boolean status = false;

        try {

            Properties props = new Properties();

            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props, new Authenticator() {

                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL, PASSWORD);
                }

            });

            // Enable Debug Output
            session.setDebug(true);

            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(EMAIL));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            message.setSubject("DOCHUB - Password Reset OTP");

            String body =
                    "Hello,\n\n"
                  + "Your One-Time Password (OTP) for resetting your DOCHUB account is:\n\n"
                  + otp
                  + "\n\nThis OTP is valid for 5 minutes."
                  + "\n\nIf you did not request this password reset, please ignore this email."
                  + "\n\nRegards,"
                  + "\nDOCHUB Team";

            message.setText(body);

            Transport.send(message);

            System.out.println("==================================");
            System.out.println("EMAIL SENT SUCCESSFULLY");
            System.out.println("To : " + toEmail);
            System.out.println("OTP : " + otp);
            System.out.println("==================================");

            status = true;

        } catch (MessagingException e) {

            System.out.println("==================================");
            System.out.println("EMAIL ERROR");
            System.out.println("==================================");

            e.printStackTrace();

        } catch (Exception e) {

            System.out.println("==================================");
            System.out.println("UNKNOWN ERROR");
            System.out.println("==================================");

            e.printStackTrace();

        }

        return status;
    }
}