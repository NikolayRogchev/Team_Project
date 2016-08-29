using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Blog.Models;
using Microsoft.AspNet.Identity;

namespace Blog.Controllers
{
   
    public class PostsController : Controller
    {
        private BlogDataEntities db = new BlogDataEntities();

      
        // GET: Post
        public ActionResult Index()
        {
            var post = db.Post.Include(p => p.User);
            return View(post.ToList());

        }

        // GET: Post/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Post post = db.Post.Find(id);
            if (post == null)
            {
                return HttpNotFound();
            }
            return View(post);
        }

        // GET: Post/Create
        public ActionResult Create()
        {
            ViewBag.UserId = new SelectList(db.User, "UserId", "Username");
            return View();
        }

        // POST: Post/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "PostId,UserId,Title,About,Content,DatePosted,CategoryId")] Post post)
        {
            if (ModelState.IsValid)
            {
                db.Post.Add(post);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.UserId = new SelectList(db.User, "UserId", "Username", post.UserId);
            return View(post);
        }

        // GET: Post/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Post post = db.Post.Find(id);
            if (post == null)
            {
                return HttpNotFound();
            }
            ViewBag.UserId = new SelectList(db.User, "UserId", "Username", post.UserId);
            return View(post);
        }

        // POST: Post/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "PostId,UserId,Title,About,Content,DatePosted,CategoryId,Comment,Tag")] Post post)
        {
            if (ModelState.IsValid)
            {
                db.Entry(post).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.UserId = new SelectList(db.User, "UserId", "Username", post.UserId);
            return View(post);
        }

        // GET: Post/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Post post = db.Post.Find(id);
            if (post == null)
            {
                return HttpNotFound();
            }
            return View(post);
        }

        // POST: Post/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Post post = db.Post.Find(id);
            db.Post.Remove(post);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

      
        public ActionResult Comment()
        {
            if (User.Identity.Name == "")
            {
                TempData["toLoginAllert"] = "To comment a post please log in.";
                return RedirectToAction("Index", "Home");
            }

            return View("Comment");
        }

        [HttpPost]
        public ActionResult Comment(int postId, int? userId, Comment comment)
        {
            if (ModelState.IsValid)
            {
                var userName = User.Identity.Name;
                var user = db.User.FirstOrDefault(u => u.Username == userName);


                var newComment = db.Comment.Create();
                newComment.Content = comment.Content;
                newComment.UserId = user.UserId;
                newComment.PostId = postId;
                newComment.DatePublished = DateTime.Now;
                db.Comment.Add(newComment);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.UserId = new SelectList(db.User, "UserId", "Username", comment.UserId);
            return View(comment);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
