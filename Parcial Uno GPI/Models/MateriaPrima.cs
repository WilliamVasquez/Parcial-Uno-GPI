//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Parcial_Uno_GPI.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class MateriaPrima
    {
        public int idMaterial { get; set; }
        public string nombreMat { get; set; }
        public string descripcionMat { get; set; }
        public Nullable<double> stock { get; set; }
        public Nullable<double> stockMinimo { get; set; }
    }
}