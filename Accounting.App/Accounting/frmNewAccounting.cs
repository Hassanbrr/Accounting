using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity.Core.Common.CommandTrees;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Accounting.DataLayer.Context;
using ValidationComponents;
using Accounting = Accounting.DataLayer.Accounting;

namespace Accounting.App
{
    public partial class frmNewAccounting : Form
    {
        UnitOfWork db = new UnitOfWork();
        public int AccountID = 0;
        public frmNewAccounting()
        {
            InitializeComponent();
        }

        private void frmNewAccounting_Load(object sender, EventArgs e)
        {
            dgvCustomeers.AutoGenerateColumns = false;
            dgvCustomeers.DataSource = db.CustomerRepository.GetNameCustomers();
      if(AccountID != 0)
            {
               var account = db.AccountingRepository.GetById(AccountID);
               txtAmount.Text = account.Amount.ToString();
                txtDescription.Text = account.Description.ToString();
                txtName.Text = db.CustomerRepository.GetCustomerNameById(account.CostomerID);
                if(account.TypeID == 1)
                {
                    rbRecive.Checked = true;
                }
                else
                {
                    rbPay.Checked = true;
                }
                this.Text = "وریایش";
                btnSave.Text = "ویرایش";
            }
        }

        private void txtFilter_TextChanged(object sender, EventArgs e)
        {
            dgvCustomeers.AutoGenerateColumns = false;
            dgvCustomeers.DataSource = db.CustomerRepository.GetNameCustomers(txtFilter.Text);
        }

        private void dgvCustomeers_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txtName.Text = dgvCustomeers.CurrentRow.Cells[0].Value.ToString();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (BaseValidator.IsFormValid(this.components))
            {
                if (rbPay.Checked || rbRecive.Checked)
                {
                    DataLayer.Accounting accounting=new DataLayer.Accounting()
                    {
                        Amount = int.Parse(txtAmount.Value.ToString()),
                        CostomerID = db.CustomerRepository.GetCustomerIdByName(txtName.Text),
                        TypeID = (rbRecive.Checked)?1:2,
                        DateTitle = DateTime.Now,
                        Description = txtDescription.Text
                       
                    };
                    if(AccountID  == 0)
                    {

                    db.AccountingRepository.Insert(accounting);
                    db.Save();

                    }
                    else
                    {
                        
                        using(UnitOfWork db2 = new UnitOfWork()) { 
                        accounting.ID = AccountID;
                        db2.AccountingRepository.Update(accounting);
                            db2.Save();
                        }
                    }
                    DialogResult = DialogResult.OK;
                }
                else
                {
                    RtlMessageBox.Show("لطفا نوع تراکنش را انتخاب کنید");
                }
            }
        }
    }
}
