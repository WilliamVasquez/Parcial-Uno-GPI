using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Parcial_Uno_GPI.Models
{
    public class Utilidades
    {
        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }
        public static bool Estado(string pass, string passBase)
        {
            //lo comentado es para crear si es que hacemos un registrar y seria de hacer el metodo en la clase obviamente...
            /*string random_bytes = null;
            string sal = null;
            byte[] Brandom = new Byte[100];
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            rng.GetBytes(Brandom);
            random_bytes = System.Text.RegularExpressions.Regex.Replace(Encoding.UTF8.GetString(Brandom), "[^0-9a-zA-ZñÑ@¿?=)(/&%$#![\\]^]+", "");
            sal = Base64Encode(random_bytes);
            sal = sal.Replace('+', '.');
            sal = sal.Substring(0, 24);//para que no se bugee ni sea muy grande se muere si llega a 70 error de framework alv*/
            //string hash = BCrypt.Net.BCrypt.HashPassword(pass, "$2a$10$" + sal); // siempre guarda un length de 60 
            bool doesPasswordMatch = BCrypt.Net.BCrypt.Verify(pass, passBase);//comprobar que la mierda es igual solo si password coincide
            return doesPasswordMatch;
        }
    }
}